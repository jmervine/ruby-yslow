# -*- encoding: utf-8 -*-
require File.expand_path("../lib/yslow/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "yslow"
  gem.homepage = "http://mervine.net/projects/gems/yslow"
  gem.version = YSlow::VERSION
  gem.license = "MIT"
  gem.files = `git ls-files`.split($\)
  gem.require_paths = ["lib"]
  gem.summary = %Q{A Ruby wrapper for YSlow via PhantomJS}
  gem.description = gem.summary
  gem.email = "joshua@mervine.net"
  gem.authors = ["Joshua P. Mervine"]

  gem.add_dependency "json" if RUBY_VERSION.start_with? "1.8"
  gem.add_dependency "phantomjs", "~> 1.9"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest", "~> 4.7.5"
  gem.add_development_dependency "minitest-reporters", "~> 0.14.24"
end
