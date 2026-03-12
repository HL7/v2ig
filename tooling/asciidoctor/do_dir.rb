require_relative 'build'

def make_html(dir, dry_run = false)
  files = Dir.glob(File.join(dir, '**/*.adoc'))
  if dry_run
    puts files
  else
    files.each do |f|
      Asciidoctor.convert_file(f,
                               doctype: :book,
                               mkdirs: true,
                               safe: :unsafe)
    end
  end
end

dir = ARGV[0] || File.expand_path('../../website/domains', __dir__)
make_html(dir)
