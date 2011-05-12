module Notedown::Helpers
  # Returns the indexes of items in a given +arr+ match the criteria
  # in a given block.
  #
  #   indexes([15, 90, 25, 42]) { |i| i % 2 }  #=> [1, 3]
  #
  def indexes(arr, &blk) # :nodoc:
    re = Array.new
    arr.each_with_index { |item, i| re << i  if blk.call(item) }
    re
  end
  
  # Returns the indentation level for a string.
  #
  #   level_of "  hello"  #=> 2
  #
  def level_of(str) # :nodoc:
    str.scan(/^ */).first.length
  end

  # Checks if a given element is in all sublists in a list.
  def all_include?(list, what) # :nodoc:
    list.select { |item| ! item.include?(what) }.empty?
  end
end
