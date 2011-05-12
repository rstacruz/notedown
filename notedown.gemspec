require "./lib/notedown"
Gem::Specification.new do |s|
  s.name = "notedown"
  s.version = Notedown.version
  s.summary = "Markup language designed for taking notes."
  s.description = "Notedown is a markup language designed for outliner-style documents. It is optimized to be inputted fast (like when you're taking notes), yet still retain the ability to export the documents as nicely-formatted HTML."
  s.authors = ["Rico Sta. Cruz"]
  s.email = ["rico@sinefunc.com"]
  s.homepage = "http://github.com/rstacruz/notedown"
  s.files = Dir["{bin,lib,test}/**/*", "*.md", "Rakefile"].reject { |f| File.directory?(f) }

  s.executables = ["notedown"]
end
