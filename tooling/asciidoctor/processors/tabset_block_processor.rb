class TabSetBlockProcessor < Asciidoctor::Extensions::BlockProcessor
  use_dsl

  named :"tabset"
  on_context :paragraph
  # parse_content_as :simple
  parse_content_as :raw

  def process(parent, reader, attrs)
    content = []
    reader.lines.each do |line|
      vals = line.split(/\s/)
      if vals.size != 2
        puts Rainbow(line).red
        pp attrs
        reader.lines.each_with_index { |l, i| puts i.to_s + ' ' + l.inspect }
        raise "tabset had vals: #{vals.inspect}"
      end 
      type = vals.first
      msg  = vals.last
      case type
      when 'message_structure'
        # FIXME do stuff to build whatever needs to be built here
        content << "TODO: Insert message structure for #{msg.gsub!('^', '&#x5e;')} here. +"
      when 'ack_chor'
        # FIXME do stuff to build whatever needs to be built here
        content << "TODO: Insert acknowledgement choreography for #{msg.gsub!('^', '&#x5e;')} here. +"
      else
        raise "Unknown tab type '#{type}' in tabset."
      end
    end
    create_paragraph(parent, content.join("\n{empty} +\n"), attrs)
  end
  
end
