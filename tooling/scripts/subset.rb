#!/usr/bin/env ruby
# frozen_string_literal: true

# subset.rb — Manages the representative resource subset for development.
#
# The subset is defined as a list of resource IDs organized by type.
# This script can:
#   - List what's in the subset
#   - Copy subset resources to a staging area
#   - Validate that all referenced resources are included
#
# Usage:
#   ruby subset.rb list          # Show subset contents
#   ruby subset.rb validate      # Check for missing dependencies
#   ruby subset.rb copy <dest>   # Copy subset to destination directory

require 'json'
require 'fileutils'

# Representative subset definition.
# Selected to cover all resource types and demonstrate key structural patterns:
#   - ADT^A01 (Admit/Visit Notification): most common V2 message
#   - ACK-A01: acknowledgement for ADT^A01
#   - Includes segment groups (NEXT_OF_KIN, OBSERVATION, PROCEDURE, INSURANCE)
#   - Covers primitive types, complex types, segments, messages, events, structures
SUBSET = {
  # Primitive data types — cover the most commonly referenced types
  primitive_data_types: %w[ST ID IS NM DT DTM SI],

  # Complex data types — cover common patterns (coded, name, address, identifier, etc.)
  complex_data_types: %w[CWE CX XPN XAD HD PL XTN AD XON SI_IZ MSG EI],

  # Segments — the segments used in ADT_A01-A message structure (core ones)
  segments: %w[MSH EVN PID PD1 PV1 PV2 NK1 AL1 OBX DG1 GT1 IN1 IN2 IN3
               SFT UAC ARV ROL PRT DB1 IAM DRG PR1 ACC UB1 UB2 PDA
               GSP GSR GSC OH1 OH2 OH3 OH4 AUT RF1 MSA ERR],

  # Message structures — ADT_A01-A (full admit) and ACK-A (simple acknowledgement)
  message_structures: %w[ADT_A01-A ACK-A],

  # Messages — ADT-A01 and its acknowledgement
  messages: %w[ADT-A01 ACK-A01],

  # Events
  events: %w[A01],
}

# Directory paths
SOT_DIR = File.expand_path('../../input/sourceOfTruth', __dir__)
PATHS = {
  primitive_data_types: File.join(SOT_DIR, 'data-type', 'primitive', 'primitives'),
  complex_data_types: File.join(SOT_DIR, 'data-type', 'complex', 'complex-data-types'),
  segments: File.join(SOT_DIR, 'segment', 'segments'),
  message_structures: File.join(SOT_DIR, 'message-structure', 'message_structures'),
  messages: File.join(SOT_DIR, 'message', 'messages'),
  events: File.join(SOT_DIR, 'event', 'events'),
}

# Supporting files that are always needed (profiles, base definitions, code systems, value sets, extensions)
SUPPORTING_FILES = [
  # Data type profiles and bases
  'data-type/primitive/primitive-data-type-profile.json',
  'data-type/primitive/v2-cs-primitives.json',
  'data-type/primitive/v2-vs-primitives.json',
  'data-type/complex/complex-data-type-profile.json',
  'data-type/complex/complex-data-type.json',
  'data-type/complex/v2-cs-complex-data-types.json',
  'data-type/complex/v2-vs-complex-data-types.json',
  'data-type/v2-vs-data-types.json',
  # Segment profiles and bases
  'segment/segment-profile.json',
  'segment/segment.json',
  'segment/v2-cs-segments.json',
  'segment/v2-vs-segments.json',
  # Message structure profiles and bases
  'message-structure/message-structure-profile.json',
  'message-structure/message-structure.json',
  'message-structure/v2-cs-message-structures.json',
  'message-structure/v2-vs-message-structures.json',
  # Message profiles and bases
  'message/message_profile.json',
  'message/message.json',
  'message/v2-cs-messages.json',
  'message/v2-vs-messages.json',
  # Event profiles and bases
  'event/event-profile.json',
  'event/event.json',
  'event/v2-cs-events.json',
  'event/v2-vs-events.json',
  # Acknowledgement choreography
  'acknowledgement-choreography/acknowledgement-choreography-profile.json',
  'acknowledgement-choreography/acknowledgement-choreography.json',
  'acknowledgement-choreography/v2-cs-acknowledgement-choreographies.json',
  'acknowledgement-choreography/v2-vs-acknowledgement-choreographies.json',
]

def list_subset
  total = 0
  SUBSET.each do |type, ids|
    puts "\n#{type} (#{ids.size}):"
    ids.each do |id|
      path = File.join(PATHS[type], "#{id}.json")
      exists = File.exist?(path)
      status = exists ? "OK" : "MISSING"
      puts "  #{id} [#{status}]"
    end
    total += ids.size
  end

  puts "\nSupporting files (#{SUPPORTING_FILES.size}):"
  SUPPORTING_FILES.each do |f|
    path = File.join(SOT_DIR, f)
    exists = File.exist?(path)
    status = exists ? "OK" : "MISSING"
    puts "  #{f} [#{status}]"
  end

  puts "\nTotal subset resources: #{total}"
  puts "Total supporting files: #{SUPPORTING_FILES.size}"
  puts "Grand total: #{total + SUPPORTING_FILES.size}"
end

def validate_subset
  missing = []
  warnings = []

  SUBSET.each do |type, ids|
    ids.each do |id|
      path = File.join(PATHS[type], "#{id}.json")
      unless File.exist?(path)
        missing << "#{type}/#{id}"
        next
      end

      # Check for references to resources not in the subset
      json = JSON.parse(File.read(path))
      if json['differential'] && json['differential']['element']
        json['differential']['element'].each do |elem|
          next unless elem['type']
          elem['type'].each do |t|
            code = t['code']
            next unless code&.start_with?('http://hl7.org/v2/StructureDefinition/')
            ref_id = code.sub('http://hl7.org/v2/StructureDefinition/', '')
            # Check if referenced resource is in subset
            found = SUBSET.any? { |_type, ids| ids.include?(ref_id) }
            unless found || ref_id == 'Segment' || ref_id == 'complex-data-type' ||
                   ref_id == 'MessageStructure' || ref_id == 'Message' || ref_id == 'Event'
              warnings << "#{type}/#{id} references #{ref_id} which is not in subset"
            end
          end
        end
      end
    end
  end

  SUPPORTING_FILES.each do |f|
    path = File.join(SOT_DIR, f)
    missing << "supporting/#{f}" unless File.exist?(path)
  end

  if missing.any?
    puts "MISSING FILES (#{missing.size}):"
    missing.each { |m| puts "  #{m}" }
  end

  if warnings.any?
    puts "\nREFERENCE WARNINGS (#{warnings.size}):"
    warnings.each { |w| puts "  #{w}" }
    puts "\n(Warnings are informational — the subset is designed to be representative,"
    puts " not necessarily self-contained for all transitive references.)"
  end

  if missing.empty? && warnings.empty?
    puts "Subset is valid — all files exist."
  end
end

case ARGV[0]
when 'list'
  list_subset
when 'validate'
  validate_subset
else
  puts "Usage: ruby subset.rb [list|validate]"
  puts "  list     — Show subset contents and check file existence"
  puts "  validate — Check for missing files and unresolved references"
end
