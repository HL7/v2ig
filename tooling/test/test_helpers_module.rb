require_relative 'test_helper'
require 'helpers'

# Create a test harness class that includes the helpers module,
# since the helpers are designed as a mixin.
class HelpersHarness
  include V2AsciidocterProcessorHelpers
end

class TestIsHl7Er7 < Minitest::Test
  def setup
    @h = HelpersHarness.new
  end

  def test_msh_with_pipes
    assert @h.is_hl7_er7("MSH|^~\\&|SEND|FAC|REC|FAC|200102||ADT^A01")
  end

  def test_pid_with_pipes
    assert @h.is_hl7_er7("PID|1||12345^^^MR||DOE^JOHN")
  end

  def test_obx_with_pipes
    assert @h.is_hl7_er7("OBX|1|NM|123||98.6|")
  end

  def test_prose_does_not_match
    refute @h.is_hl7_er7("The PID segment carries patient demographics.")
  end

  def test_short_code_no_pipes_does_not_match
    refute @h.is_hl7_er7("MSH is the header")
  end

  def test_single_pipe_does_not_match
    refute @h.is_hl7_er7("MSH|only one pipe")
  end

  def test_segment_mid_line_does_not_match
    # Pattern requires match at start of string
    refute @h.is_hl7_er7("  MSH|^~\\&|SEND|")
  end

  def test_two_letter_segment_does_not_match
    # Must be 3 chars: 2 uppercase + 1 uppercase/digit
    refute @h.is_hl7_er7("MS|^~\\&|SEND|")
  end
end

class TestHasEr7 < Minitest::Test
  def setup
    @h = HelpersHarness.new
  end

  def test_er7_content_matches
    assert @h.has_er7?("MSH|^~\\&|SEND|")
  end

  def test_no_pipes_does_not_match
    refute @h.has_er7?("This is plain text about HL7 messaging.")
  end

  def test_matches_er7_anywhere_in_line
    # Unlike is_hl7_er7, this doesn't require start-of-string
    assert @h.has_er7?("  PID|1||12345|")
  end

  def test_single_pipe_does_not_match
    # Requires at least two pipes: pattern is SEG|...|
    refute @h.has_er7?("MSH|only")
  end
end

class TestHasMessageIdentifier < Minitest::Test
  def setup
    @h = HelpersHarness.new
  end

  def test_adt_a01_adt_a01
    assert @h.has_message_identifier?("ADT^A01^ADT_A01")
  end

  def test_ack_response
    assert @h.has_message_identifier?("ACK^A01^ACK")
  end

  def test_qbp_q25_qbp_q21
    assert @h.has_message_identifier?("QBP^Q25^QBP_Q21")
  end

  def test_partial_no_third_component_does_not_match
    refute @h.has_message_identifier?("ADT^A01")
  end

  def test_prose_does_not_match
    refute @h.has_message_identifier?("The ADT message type is used for admissions.")
  end

  def test_lowercase_does_not_match
    refute @h.has_message_identifier?("adt^a01^adt_a01")
  end

  def test_mid_line_does_not_match
    # Pattern requires start-of-string anchor
    refute @h.has_message_identifier?("  ADT^A01^ADT_A01")
  end
end
