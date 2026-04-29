#!/usr/bin/env bash
set -euo pipefail

# v2ig project provisioning script
# Installs Java 17, Ruby 3.2 (from source), Jekyll, and Asciidoctor
# for FHIR IG Publisher builds on Debian 12 aarch64
#
# Prerequisites (already in base image): gcc, make, libssl-dev, libffi-dev,
# libyaml-dev, zlib1g-dev, libreadline-dev

INSTALL_BASE="/home/claude"

###############################################################################
# Java 17 (Eclipse Temurin) — needed for FHIR IG Publisher
###############################################################################
if [ ! -f "$INSTALL_BASE/jdk/bin/java" ]; then
  echo "Installing Java 17 (Eclipse Temurin, aarch64)..."
  mkdir -p "$INSTALL_BASE/jdk"
  curl -fsSL "https://api.adoptium.net/v3/binary/latest/17/ga/linux/aarch64/jdk/hotspot/normal/eclipse" \
    -o /tmp/jdk.tar.gz
  tar xzf /tmp/jdk.tar.gz -C "$INSTALL_BASE/jdk" --strip-components=1
  rm /tmp/jdk.tar.gz
  echo "Java installed: $("$INSTALL_BASE/jdk/bin/java" -version 2>&1 | head -1)"
else
  echo "Java already installed."
fi

###############################################################################
# Ruby 3.2.6 (compiled from source) — needed for Asciidoctor and Jekyll
# Prebuilt binaries segfault on Debian 12; must compile from source.
###############################################################################
if [ ! -f "$INSTALL_BASE/ruby/arm64/bin/ruby" ]; then
  echo "Compiling Ruby 3.2.6 from source (this takes a few minutes)..."
  mkdir -p /tmp/ruby-build
  curl -fsSL "https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.6.tar.gz" \
    -o /tmp/ruby-build/ruby.tar.gz
  tar xzf /tmp/ruby-build/ruby.tar.gz -C /tmp/ruby-build
  cd /tmp/ruby-build/ruby-3.2.6
  ./configure --prefix="$INSTALL_BASE/ruby/arm64" --disable-install-doc --with-openssl-dir=/usr > /dev/null 2>&1
  make -j"$(nproc)" > /dev/null 2>&1
  make install > /dev/null 2>&1
  rm -rf /tmp/ruby-build
  echo "Ruby installed: $("$INSTALL_BASE/ruby/arm64/bin/ruby" --version)"
else
  echo "Ruby already installed."
fi

###############################################################################
# Ruby gems — Jekyll 4.4.1, Asciidoctor 2.0.26, and all dependencies
# Versions pinned to match Gemfile.lock
###############################################################################
export PATH="$INSTALL_BASE/ruby/arm64/bin:$PATH"
export GEM_HOME="$INSTALL_BASE/.gems"
export GEM_PATH="$INSTALL_BASE/.gems:$INSTALL_BASE/ruby/arm64/lib/ruby/gems/3.2.0"

if ! gem list -i jekyll > /dev/null 2>&1; then
  echo "Installing Ruby gems..."
  gem install jekyll asciidoctor rainbow --no-document
  # Exact versions from Gemfile.lock for Bundler compatibility
  gem install activesupport:7.2.3 connection_pool:2.5.5 minitest:5.27.0 \
              concurrent-ruby i18n --no-document
  echo "Gems installed."
else
  echo "Ruby gems already installed."
fi

###############################################################################
# Jekyll wrapper script — sets env vars so IG Publisher can find it
###############################################################################
mkdir -p "$INSTALL_BASE/bin"
cat > "$INSTALL_BASE/bin/jekyll" << 'WRAPPER'
#!/usr/bin/env bash
export LD_LIBRARY_PATH="/home/claude/ruby/arm64/lib:${LD_LIBRARY_PATH:-}"
export GEM_HOME="/home/claude/.gems"
export GEM_PATH="/home/claude/.gems:/home/claude/ruby/arm64/lib/ruby/gems/3.2.0"
export BUNDLE_GEMFILE=""
exec /home/claude/ruby/arm64/bin/ruby -r rubygems /home/claude/.gems/bin/jekyll "$@"
WRAPPER
chmod +x "$INSTALL_BASE/bin/jekyll"

###############################################################################
# SSH keys (if provided via .ssh-keys/ in project root)
###############################################################################
SSH_KEYS_DIR="/workspace/.ssh-keys"
if [ -d "$SSH_KEYS_DIR" ] && [ "$(ls -A "$SSH_KEYS_DIR" 2>/dev/null)" ]; then
  echo "Installing SSH keys from .ssh-keys/..."
  mkdir -p "$HOME/.ssh"
  cp "$SSH_KEYS_DIR"/* "$HOME/.ssh/"
  chmod 700 "$HOME/.ssh"
  chmod 600 "$HOME/.ssh"/*
  # Make .pub files world-readable if present
  chmod 644 "$HOME/.ssh"/*.pub 2>/dev/null || true
  echo "SSH keys installed."
else
  echo "No SSH keys found in .ssh-keys/ (optional)."
fi

###############################################################################
# GitHub CLI (gh) — for inspecting webhooks, PRs, issues, releases
###############################################################################
if [ ! -f "$INSTALL_BASE/gh/bin/gh" ]; then
  echo "Installing GitHub CLI (gh) for aarch64..."
  GH_VERSION="2.92.0"
  mkdir -p "$INSTALL_BASE/gh"
  curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_arm64.tar.gz" \
    -o /tmp/gh.tar.gz
  tar xzf /tmp/gh.tar.gz -C "$INSTALL_BASE/gh" --strip-components=1
  rm /tmp/gh.tar.gz
  echo "gh installed: $("$INSTALL_BASE/gh/bin/gh" --version | head -1)"
else
  echo "gh already installed."
fi

###############################################################################
# Python packages (for vocabulary extraction/comparison)
###############################################################################
if ! python3 -c "import docx" 2>/dev/null; then
  echo "Installing python-docx..."
  pip install --break-system-packages python-docx 2>/dev/null || pip install python-docx 2>/dev/null || true
fi

if ! python3 -c "import pytest" 2>/dev/null; then
  echo "Installing pytest..."
  pip install --break-system-packages pytest 2>/dev/null || pip install pytest 2>/dev/null || true
fi

if ! python3 -c "import anthropic" 2>/dev/null; then
  echo "Installing anthropic + pydantic (for LLM-mediated V291 extraction)..."
  pip install --break-system-packages anthropic pydantic 2>/dev/null || pip install anthropic pydantic 2>/dev/null || true
fi

###############################################################################
# Summary
###############################################################################
echo ""
echo "=== Provisioning complete ==="
echo "Java:    $("$INSTALL_BASE/jdk/bin/java" -version 2>&1 | head -1)"
echo "Ruby:    $("$INSTALL_BASE/ruby/arm64/bin/ruby" --version)"
echo "Jekyll:  $("$INSTALL_BASE/bin/jekyll" --version)"
echo ""
echo "Add to PATH:"
echo "  export PATH=\"$INSTALL_BASE/bin:$INSTALL_BASE/jdk/bin:$INSTALL_BASE/ruby/arm64/bin:$INSTALL_BASE/gh/bin:\$PATH\""
echo "  export JAVA_TOOL_OPTIONS=\"-Dfile.encoding=UTF-8\""
echo "  export GEM_HOME=\"$INSTALL_BASE/.gems\""
echo "  export GEM_PATH=\"$INSTALL_BASE/.gems:$INSTALL_BASE/ruby/arm64/lib/ruby/gems/3.2.0\""
