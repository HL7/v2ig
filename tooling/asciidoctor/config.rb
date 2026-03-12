require 'rainbow'
Dir.glob(File.join(__dir__, 'processors', '**', '*.rb'), &method(:load))

Asciidoctor::Extensions.register do
  preprocessor CaretPreprocessor # changes caret symbol to HTML entity in inline message identifiers
  block TabSetBlockProcessor
end
