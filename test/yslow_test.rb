require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "./lib/yslow"

class TestYSlow < Minitest::Unit::TestCase
  def test_path
    assert File.exists?(YSlow.path)

    YSlow.path "foo.js"
    assert_equal "foo.js", YSlow.path
  end

  def test_phantomjs
    assert File.exists?(YSlow.phantomjs)

    YSlow.phantomjs "foo"
    assert_equal "foo", YSlow.phantomjs
  end

  def test_good_run
    YSlow.phantomjs File.expand_path("stubs/phantomjs-pass", File.dirname(__FILE__))

    res = YSlow.run "http://www.example.com"

    assert_kind_of ::YSlow::Result, res
    assert_equal "{ \"foo\": \"bar\" }", res.to_s
  end

  def test_bad_run
    YSlow.phantomjs File.expand_path("stubs/phantomjs-fail", File.dirname(__FILE__))

    res = YSlow.run "http://www.example.com"

    assert_kind_of ::YSlow::Result, res
    assert_equal "Error", res.to_s
  end
end
