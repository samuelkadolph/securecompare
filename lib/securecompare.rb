module SecureCompare
  require "securecompare/version"

  # constant-time comparison algorithm to prevent timing attacks; borrowed from ActiveSupport::MessageVerifier
  def secure_compare(a, b)
    return false unless a.bytesize == b.bytesize

    l = a.unpack("C#{a.bytesize}")

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end
  module_function :secure_compare

  class << self
    alias_method :compare, :secure_compare
  end
end
