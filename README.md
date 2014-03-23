YSlow on Ruby
=============

[![Build Status](https://travis-ci.org/jmervine/ruby-yslow.svg?branch=v0.0.1)](https://travis-ci.org/jmervine/ruby-yslow) &nbsp; ![Gem Version](https://badge.fury.io/rb/yslow.png)

Ruby wrapper for [YSlow](http://yslow.org/phantomjs/) via [PhantomJS](http://phantomjs.org/).


Install
-------

    gem install yslow

    # via bundler
    bundle init
    echo "gem 'yslow'" >> Gemfile
    bundle install


Example Usage
-------------

    :::ruby
    #!/usr/bin/ruby
    require "yslow"

    YSlow.path
    # => /path/to/yslow.js
    #
    # Accepts custom path
    # YSlow.path "/path/to/yslow.js"

    YSlow.phantomjs
    # => /path/to/phantomjs
    #
    # Accepts custom path
    # YSlow.phantomjs "/path/to/phantomjs"

    result = YSlow.run "http://www.example.com"
          # , [ .. other yslow args .. ]

    result
    # => YSlow::Result

    result.result
    # yslow result hash

    # YSlow::Result#result  :: raw result hash
    # YSlow::Result#status  :: exit status
    # YSlow::Result#stdout  :: raw stdout string
    # YSlow::Result#stderr  :: raw stderr string
    # YSlow::Result#to_i    :: exit status
    # YSlow::Result#to_s    :: stdout if pass, else stderr
    # YSlow::Result#to_json :: stdout as json if passed, else result as json
    # YSlow::Result#to_h    :: parsed stdout hash if passed, else result as hash

> See [examples/basic.rb](https://github.com/jmervine/ruby-yslow/blob/master/examples/basic.rb) for a runnable example.

Example Usage: Test
-------------------

    :::ruby
    require "minitest/autorun"
    require "yslow"

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

> See [examples/minitest.rb](https://github.com/jmervine/ruby-yslow/blob/master/examples/minitest.rb) for a runnable example.

Development
-----------

    git clone https://github.com/jmervine/ruby-yslow.git
    cd ruby-yslow
    bundle install --path vendor/bundle
    bundle exec rake test

