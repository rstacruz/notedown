require 'test/unit'
require 'contest'
require 'yaml'
require File.expand_path('../../lib/notedown', __FILE__)

class NTest < Test::Unit::TestCase
  def fixture(file)
    File.expand_path("../fixtures/#{file}", __FILE__)
  end

  def assert_fixture(name)
    from = File.read(fixture("#{name}.nd"))
    to   = File.read(fixture("#{name}.html"))
    ins  = File.read(fixture("#{name}.debug"))

    doc = Notedown.parse(from)

    #assert_equal to, doc.to_html
    assert_equal ins.strip, doc.inspect.strip
  end

  test "first" do
    assert_fixture 'first'
  end

  test "sugar" do
    assert_fixture 'sugar'
  end
end
