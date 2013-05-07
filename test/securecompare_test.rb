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

  describe "Performance" do
    bench_range do
      bench_exp(1, 1_000_000)
    end

    bench_performance_constant "strings of non equal size" do |n|
      base = "a" * n
      SecureCompare.secure_compare(base + "a", base)
    end

    bench_performance_linear "strings of equal size", 0.99999 do |n|
      base = "a" * n
      SecureCompare.secure_compare(base + "a", base + "b")
    end
  end
end
