require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "./lib/yslow/result"

class TestYSlowResult < Minitest::Unit::TestCase
  def test_status
    res = YSlow::Result.new(result)
    assert res.status
    assert_equal 0, res.status
  end

  def test_stdout
    res = YSlow::Result.new(result)
    assert res.stdout
    assert_equal "stdout message", res.stdout
  end

  def test_stderr
    res = YSlow::Result.new(result)
    assert res.stderr
    assert_equal "stderr message", res.stderr
  end

  def test_good_result
    res = YSlow::Result.new(result)
    assert res.result
    assert_equal "stdout message", res.result[:stdout]
  end

  def test_bad_result
    res =YSlow::Result.new(result(1))
    assert res.status
    assert_equal 1, res.status
  end

  def test_to_i_stdout
    res = YSlow::Result.new(result)
    assert_equal 0, res.to_i
  end

  def test_to_i_stderr
    res = YSlow::Result.new(result(1))
    assert_equal 1, res.to_i
  end

  def test_to_s_stdout
    res = YSlow::Result.new(result)
    assert_equal "stdout message", res.to_s
  end

  def test_to_s_stderr
    res = YSlow::Result.new(result(1))
    assert_equal "stderr message", res.to_s
  end

  def test_to_json_good
    res = YSlow::Result.new(result(0, "{\"code\":200}"))
    assert_equal "{\"code\":200}", res.to_json
  end

  def test_to_json_bad
    res = YSlow::Result.new(result(1))
    assert_equal "{\"status\":1,\"stdout\":\"stdout message\",\"stderr\":\"stderr message\"}", res.to_json
  end

  def test_to_json_ugly
    res = YSlow::Result.new(result)
    assert_equal "{\"status\":0,\"stdout\":\"stdout message\",\"stderr\":\"stderr message\"}", res.to_json
  end

  def test_to_h_good
    res = YSlow::Result.new(result(0, "{\"code\":200}"))
    assert_equal({"code" => 200}, res.to_h)
    assert_equal({"code" => 200}, res.to_hash)
  end

  def test_to_h_ugly
    res = YSlow::Result.new(result)
    assert_equal result, res.to_h
    assert_equal result, res.to_hash
  end

  def test_to_h_bad
    res = YSlow::Result.new(result(1))
    assert_equal result(1), res.to_h
    assert_equal result(1), res.to_hash
  end

  def result status=0, stdout="stdout message"
    return {
      :status => status,
      :stdout => stdout,
      :stderr => "stderr message"
    }
  end
end
