# frozen_string_literal: true

require "test_helper"

class JsonWebTokenTest < ActiveSupport::TestCase
  test "encode valid payload" do
    jwt = JsonWebToken.encode(password: "12345")
    assert_not_nil jwt
  end

  test "encode invalid payload" do
    jwt = JsonWebToken.encode("non-hash data")
    assert_nil jwt
  end

  test "decode valid token" do
    jwt = JsonWebToken.encode(password: "12345")
    decoded = JsonWebToken.decode(jwt)
    assert_equal "12345", decoded[:password]
  end

  test "decode invalid token" do
    assert_nil JsonWebToken.decode(nil)
    assert_nil JsonWebToken.decode("invalid.token")
    assert_nil JsonWebToken.decode(Object.new)
  end
end
