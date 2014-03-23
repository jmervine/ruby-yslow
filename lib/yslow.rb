require "phantomjs"
require "open3"

require File.expand_path("yslow/version", File.dirname(__FILE__))
require File.expand_path("yslow/result",  File.dirname(__FILE__))

module YSlow
  def self.phantomjs value=nil
    @@phantomjs = value unless value.nil?
    @@phantomjs ||= Phantomjs.path
  end

  def self.path value=nil
    @@path = value unless value.nil?
    @@path ||= File.expand_path("yslow.js", File.dirname(__FILE__))
  end

  def self.run url, command=[]
    command.push("--format")
    command.push("json")
    command.push(url)

    command.unshift(self.path)
    command.unshift(self.phantomjs)

    err, out, status = nil
    ::Open3.popen3(command.join(" ")) do |i, o, e, t|
      err = e.read.chomp
      out = o.read.chomp

      status = t.value.to_i
    end

    Result.new({
      :status => status,
      :stdout => out,
      :stderr => err
    })
  end
end
