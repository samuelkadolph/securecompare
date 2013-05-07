[![Build Status](https://secure.travis-ci.org/samuelkadolph/securecompare.png?branch=master)](http://travis-ci.org/samuelkadolph/securecompare)
[![Gem Version](https://badge.fury.io/rb/securecompare.png)](http://badge.fury.io/rb/securecompare)
[![Dependency Status](https://gemnasium.com/samuelkadolph/securecompare.png)](https://gemnasium.com/samuelkadolph/securecompare)
[![Code Climate](https://codeclimate.com/github/samuelkadolph/securecompare.png)](https://codeclimate.com/github/samuelkadolph/securecompare)

# securecompare

securecompare is a gem that implements a constant time string comparison method safe for use in cryptographic functions.

## Description

securecompare borrows the `secure_compare` private method from `ActiveSupport::MessageVerifier` which lets you do safely compare strings without being vulnerable to timing attacks. Useful for Basic HTTP Authentication in your rack/rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "securecompare"
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install securecompare
```

## Usage

```ruby
require "securecompare"

SecureCompare.compare("password", "password") # => true
SecureCompare.compare("password", "passw0rd") # => false
```

```ruby
require "securecompare"

class Password < String
  include SecureCompare

  def ==(other)
    secure_compare(self, other)
  end
end

Password.new("password") == "password" # => true
Password.new("password") == "passw0rd" # => false
```

```ruby
require "securecompare"

class ApplicationController < ActionController::Base
  include SecureCompare

  before_filter :authenticate

  proctected
  def authenticate
    authenticate_or_request_with_http_basic("My Rails App") do |username, password|
      secure_compare(username, "username") & secure_compare(password, "password")
    end
  end
end
```

## Contributing

Fork, branch & pull request.
