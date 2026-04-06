#!/usr/bin/env ruby
# frozen_string_literal: true

# Converts [er7] and [er7-example] paragraph blocks in AsciiDoc files
# to standard AsciiDoc literal blocks using .... delimiters.
#
# Before:
#   [er7]
#   | some ER7 content |
#   more content
#
# After:
#   [.er7]
#   ....
#   | some ER7 content |
#   more content
#   ....
#
# Handles consecutive [er7] blocks with no blank line between them by
# treating each [er7] marker as the start of a new block.

require 'find'

WEBSITE_DIR = File.expand_path('../../website', __dir__)

# Matches lines like [er7] or [er7-example]
ER7_MARKER = /^\[(er7(?:-example)?)\]\s*$/

def convert_file(filepath)
  lines = File.readlines(filepath)
  output = []
  changes = []
  i = 0

  while i < lines.length
    line = lines[i]

    if line =~ ER7_MARKER
      marker_type = $1
      marker_line_num = i + 1 # 1-based for reporting
      css_class = ".#{marker_type}"

      # Collect content lines: stop at blank line, EOF, or another [er7] marker
      i += 1
      content_lines = []
      while i < lines.length && lines[i].strip != '' && lines[i] !~ ER7_MARKER
        content_lines << lines[i]
        i += 1
      end

      if content_lines.empty?
        # No content after marker -- leave it unchanged
        output << line
        next
      end

      # Write the converted block
      output << "[#{css_class}]\n"
      output << "....\n"
      content_lines.each { |cl| output << cl }
      output << "....\n"

      # Preserve the blank line that terminated the paragraph, if present
      # (but not if we stopped at another [er7] marker)
      if i < lines.length && lines[i].strip == ''
        output << lines[i]
        i += 1
      end

      changes << "  Line #{marker_line_num}: [#{marker_type}] -> [#{css_class}] with literal block (#{content_lines.length} content line(s))"
    else
      output << line
      i += 1
    end
  end

  [output, changes]
end

def main
  total_files = 0
  total_blocks = 0

  adoc_files = []
  Find.find(WEBSITE_DIR) do |path|
    next unless path.end_with?('.adoc')
    content = File.read(path)
    next unless content.lines.any? { |line| line =~ ER7_MARKER }
    adoc_files << path
  end

  adoc_files.sort.each do |filepath|
    output, changes = convert_file(filepath)
    next if changes.empty?

    relative = filepath.sub("#{WEBSITE_DIR}/", '')
    puts "#{relative} (#{changes.length} block(s) converted)"
    changes.each { |c| puts c }
    puts

    File.write(filepath, output.join)
    total_files += 1
    total_blocks += changes.length
  end

  puts "=" * 60
  puts "Done. Converted #{total_blocks} block(s) in #{total_files} file(s)."
end

main
