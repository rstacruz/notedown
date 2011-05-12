module Notedown
class Document
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def root
    @root ||= Node.new(nil, '', source.split("\n"))
  end

  def to_html
    root.to_html
  end

  def inspect
    root.inspect
  end
end
end
