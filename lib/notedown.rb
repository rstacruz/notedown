# Notedown markup.
#
# == Usage
#
#   nd = Notedown.parse("string here")
#   nd.to_html
#
class Notedown
  attr_reader :parent
  attr_reader :children

  autoload :Helpers, File.expand_path('../notedown/helpers', __FILE__)

  include Helpers

  def self.parse(str)
    new(nil, '', str.strip.split("\n"))
  end

  def initialize(parent=nil, content='', lines=Array.new)
    @content  = content.strip
    @parent   = parent
    @children = get_children(lines)
  end

  def empty?
    children.empty?
  end

  def heading_level
    level = 0
    level += parent.heading_level  if parent
    level += 1  if heading?
    level
  end

  # Returns the group types
  def group_types
    subtypes = children.map { |node| node.types }

    re = Array.new

    if subtypes.any?
      [:paragraph, :heading, :item].each do |type|
        if all_include?(subtypes, type)
          re << :"#{type}_group"
        end
      end
    end

    re
  end

  def types
    types = Array.new
    types << :leaf  if children.empty?

    if @content.empty?
      types << :group
    elsif @content[0] == '#'
      types << :heading
    elsif text[-2..-1] =~ /[^\.]\./
      types << :paragraph
    elsif text.match(/^-+$/)
      types << :hr
    else
      types << :item
    end

    types << :bold  if @content[-1] == ':'

    types + group_types
  end

  def text
    @content.gsub(/^[#] */, '').gsub(/:$/, '')
  end

  def inspect
    s = "<%s> \"%s\"" % [types.join('.'), text]

    ([s] + children.map { |l| "#{l.inspect.gsub(/^/, '  ')}" }).join("\n")
  end

  def paragraph?() types.include?(:paragraph) end
  def item?()      types.include?(:item) end
  def bold?()      types.include?(:bold) end
  def heading?()   types.include?(:heading) end
  def hr?()        types.include?(:hr) end
  def group?()     types.include?(:group) end

  def to_html
    (content_html + children_html).squeeze("\n")
  end

  def content_html
    text = self.text
    text = "<strong>#{text}</strong>"  if bold?

    if group?
      ""
    elsif paragraph?
      "<p>#{text}</p>\n"
    elsif item?
      "<li>#{text}</li>\n"
    elsif heading?
      n = heading_level
      "<h#{n}>#{text}</h#{n}>\n"
    elsif hr?
      "<hr>\n"
    else
      text #???
    end
  end
   
  def children_html
    html = children.map { |node| node.to_html }.join("\n")
    return ""  if html.empty?

    if types.include?(:item_group)
      "<ul>\n#{html}\n</ul>\n"
    elsif types.include?(:heading_group)
      "<section>\n#{html}\n</section>\n"
    else
      html
    end
  end

private
  def get_children(lines)
    first_meat = lines.reject { |l| l.strip.empty? }.first

    if first_meat == nil
      Array.new
    else
      indent = level_of(first_meat)

      firsts = indexes(lines) { |s| level_of(s) == indent && !s.strip.empty? }

      sections = Array.new
      (firsts+[0]).each_cons(2) { |line, next_line|
        new_group = !! lines[line-1].to_s.strip.empty?
        range     = line..(next_line-1)

        sections << [lines[range], new_group]
      }

      groups = Array.new

      sections.each { |(lines, new_group)|
        groups << Notedown.new(self)  if groups.empty? || (new_group && !groups.last.empty?)
        groups.last.children << Notedown.new(self, lines.shift, lines)
      }

      groups
    end
  end

end
