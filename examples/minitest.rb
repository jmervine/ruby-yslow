#!/usr/bin/env ruby
require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# For Jenkins, Hudson or Bamboo use JUnitReporter
#
# Minitest::Reporters.use! Minitest::Reporters::JUnitReporter.new

begin
  require "yslow"
rescue
  require File.expand_path("../lib/yslow", File.dirname(__FILE__))
end


class TestExampleDotCom < Minitest::Unit::TestCase
  def setup
    @result ||= YSlow.run "http://www.example.com"
  end

  def test_yslow_grade
    assert (95..100).include?(@result.to_h["o"]),
      "expected grade to be between 95 and 100"
            # grade was 98 when this was created
  end

  def test_requests
    assert (0..4).include?(@result.to_h["r"]),
      "expected requests to be between 0 and 4"
            # requests was 2 when this was created
  end

  def test_load_time
    assert (0..200).include?(@result.to_h["lt"]),
      "expected load time to be between 0 and 200"
            # load time was 67 when this was created
  end

  def test_size
    assert (2000..3000).include?(@result.to_h["w"]),
      "expected page size to be between 2000 and 3000"
            # load time was 2540 when this was created
  end
end
