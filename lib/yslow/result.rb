require "json"
module YSlow
  class Result
    attr_reader :status, :stderr, :stdout, :result

    def initialize res
      @result = res
      @status = res[:status]
      @stdout = res[:stdout]
      @stderr = res[:stderr]
    end

    def to_i
      status
    end

    def to_s
      if status == 0
        stdout
      else
        stderr
      end
    end

    def to_json
      if status == 0
        JSON.dump(JSON.parse(stdout)) rescue JSON.dump(result)
      else
        JSON.dump(result)
      end
    end

    def to_h
      result unless status == 0

      JSON.parse(stdout) rescue result
    end
    alias_method :to_hash, :to_h
  end
end
