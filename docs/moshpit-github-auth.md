# MoshPit Design Note: Automatic GitHub Authentication

**Date:** 2026-03-13
**Status:** Proposal
**Context:** Every MoshPit container session hits the same problem — `git push` fails because the remote is SSH (`git@github.com:...`) and there's no SSH key in the container. The workaround is a per-project `.claude-dev/provision.sh` that switches to HTTPS and configures a credential helper, but this shouldn't be per-project — it should be part of MoshPit itself.

## Problem

MoshPit already injects `GITHUB_PERSONAL_ACCESS_TOKEN` into the container environment. But git doesn't know to use it because:

1. Cloned repos typically use SSH remote URLs (`git@github.com:user/repo.git`)
2. No SSH keys exist in the container
3. No git credential helper is configured to use the token

## Proposed Solution

MoshPit should configure git credentials as part of its container startup, **before** any project provision scripts run. Two things need to happen:

### 1. Configure a global git credential helper

Add this to the container's global git config during MoshPit's own startup/entrypoint:

```bash
if [ -n "${GITHUB_PERSONAL_ACCESS_TOKEN:-}" ]; then
  git config --global credential.helper \
    '!f() { echo "username=x-access-token"; echo "password=${GITHUB_PERSONAL_ACCESS_TOKEN}"; }; f'
fi
```

This makes `git push` over HTTPS work automatically with the injected token.

### 2. Convert SSH remotes to HTTPS in mounted workspaces

After bind-mounting the project directory, convert any SSH GitHub remotes to HTTPS:

```bash
if [ -n "${GITHUB_PERSONAL_ACCESS_TOKEN:-}" ]; then
  for remote in $(git -C /workspace remote 2>/dev/null); do
    url=$(git -C /workspace remote get-url "$remote" 2>/dev/null || true)
    if echo "$url" | grep -q 'git@github.com:'; then
      https_url=$(echo "$url" | sed 's|git@github.com:|https://github.com/|')
      git -C /workspace remote set-url "$remote" "$https_url"
    fi
  done
fi
```

### Where to put this

This should run in MoshPit's container entrypoint or initialization script — the same place that sets up the environment before Claude Code starts. It should run:

- **After** environment variables are injected
- **After** the workspace is bind-mounted
- **Before** any `.claude-dev/provision.sh` runs

### What this replaces

Once MoshPit handles this globally, individual projects no longer need the git auth block in their `.claude-dev/provision.sh`. The Kelpie project currently has this workaround and it can be removed after MoshPit picks this up.

### Edge cases to consider

- **Multiple remotes:** The loop handles all remotes, not just `origin`
- **Non-GitHub remotes:** The `git@github.com:` check ensures only GitHub URLs are converted
- **Multiple workspaces:** If MoshPit supports multiple bind mounts, iterate over all workspace paths
- **Token rotation:** The credential helper reads `$GITHUB_PERSONAL_ACCESS_TOKEN` at invocation time (not at config time), so if the env var is updated the new token is used immediately
- **No token:** Both blocks are guarded by `[ -n "${GITHUB_PERSONAL_ACCESS_TOKEN:-}" ]` so they're no-ops if the token isn't set
