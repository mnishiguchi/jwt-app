# frozen_string_literal: true

require "test_helper"

class V1::Commands::AuthorizeUserRequestTest < ActiveSupport::TestCase
  DummyTestHttpRequest = Struct.new(:jwt) do
    define_method :headers do
      jwt ? { "Authorization" => "Bear #{jwt}" } : {}
    end
  end

  test "with invalid http request" do
    invalid_http_request = DummyTestHttpRequest.new(nil)
    command = V1::Commands::AuthorizeUserRequest.call(invalid_http_request)
    assert_not command.success?
    assert_nil command.result
  end

  test "with valid http request" do
    # Simulate a registered user
    email = "jimi@example.com"
    password = "good-password"
    user = create(:user, email: email, password: password)
    # Simulate logging in a user
    jwt = V1::Commands::AuthenticateUser.call(email: email, password: password).result[:jwt]
    # Simulate http request from a logged-in user
    valid_http_request = DummyTestHttpRequest.new(jwt)

    command = V1::Commands::AuthorizeUserRequest.call(valid_http_request)
    assert command.success?
    assert_not_nil command.result
    assert_instance_of User, command.result
    assert_equal user.id, command.result.id
    assert_equal user.email, command.result.email
  end
end
