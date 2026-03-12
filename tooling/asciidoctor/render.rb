require 'fileutils'

module WriteAdoc
  module_function

  def render(filename, output_dir: nil)
    str = File.read(filename)

    html_file = filename.sub(/\.adoc$/, '.html')

    Asciidoctor.convert(str,
                        doctype: :book,
                        mkdirs: true,
                        to_file: html_file,
                        safe: :unsafe)

    if output_dir
      dest = File.join(output_dir, File.basename(html_file))
      FileUtils.cp(html_file, dest)
    end
  end
end
