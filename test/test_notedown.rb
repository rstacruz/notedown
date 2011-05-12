require 'test/unit'
require 'contest'
require 'yaml'
require File.expand_path('../../lib/notedown', __FILE__)

class NTest < Test::Unit::TestCase
  test "parse" do
    str = %{
      # Hello
      
        Yes.

        So and so
          Yada
        So and so
          Yada

      # Again
        Yes
    }.strip.gsub(/^ {8}/, '')

    n = Notedown.parse(str)
    p n
    puts n.to_html
  end

  test "parse2" do
    str = File.read('lol.nd')

    n = Notedown.parse(str)
    p n
    puts n.to_html
  end
end
