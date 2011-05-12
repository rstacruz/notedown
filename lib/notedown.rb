# Notedown markup.
#
# == Usage
#
#   nd = Notedown.parse("string here")
#   nd.to_html
#
module Notedown
  VERSION = "0.0.1"

  autoload :Helpers,  File.expand_path('../notedown/helpers', __FILE__)
  autoload :Node,     File.expand_path('../notedown/node', __FILE__)
  autoload :Document, File.expand_path('../notedown/document', __FILE__)

  def self.parse(str)
    Document.new(str)
  end

  def self.version
    VERSION
  end
end
