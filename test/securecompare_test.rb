require "test_helper"

describe SecureCompare do
  it "should return true for equal strings" do
    SecureCompare.secure_compare("abc", "abc").must_equal(true)
  end

  it "should return false for not equal strings" do
    SecureCompare.secure_compare("abc", "def").must_equal(false)
  end

  it "should respond to compare" do
    SecureCompare.must_respond_to(:compare)
  end

  it "should add secure_compare to anything that includes it" do
    klass = Class.new
    klass.send(:include, SecureCompare)
    klass.private_instance_methods.include?(:secure_compare).must_equal(true)
  end

  it "should add secure_compare to anything that extends it" do
    klass = Class.new
    klass.send(:extend, SecureCompare)
    klass.private_methods.include?(:secure_compare).must_equal(true)
  end

  it "takes nearly the same time to compare different strings" do
    max_length = 100_000

    aaaa = "a" * max_length
    abbb = "a" + "b" * (max_length - 1)
    aaab = "a" * (max_length - 1) + "b"

    timings = [abbb, aaab].map do |string|
      start_time = Time.now

      100.times do
        SecureCompare.secure_compare(string, aaaa)
      end

      Time.now - start_time
    end

    assert_in_epsilon 1, timings.max/timings.min, 0.1
  end
end
