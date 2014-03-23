#!/usr/bin/ruby
begin
  require "yslow"
rescue
  require File.expand_path("../lib/yslow", File.dirname(__FILE__))
end

require "pp"

puts "YSlow.path"
pp YSlow.path

puts "YSlow.phantomjs"
pp YSlow.phantomjs

result = YSlow.run "http://www.example.com"

puts "YSlow::Result#to_h"
pp result.to_h
