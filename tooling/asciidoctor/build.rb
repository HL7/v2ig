require 'asciidoctor'
require 'fileutils'

paths = %w{config}
paths.each { |path| load File.expand_path("#{path}.rb", __dir__) }
