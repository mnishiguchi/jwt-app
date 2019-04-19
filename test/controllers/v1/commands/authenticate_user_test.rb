# frozen_string_literal: true

require "test_helper"

class V1::Commands::AuthenticateUserTest < ActiveSupport::TestCase
  def setup
    @email = "jimi@example.com"
    @password = "good-password"
    create(:user, email: @email, password: @password)
  end

  test "with invalid user credentials" do
    command = V1::Commands::AuthenticateUser.call(email: "invalid", password: "abc")
    assert_not command.success?
    assert_nil command.result
  end

  test "with valid user credentials" do
    command = V1::Commands::AuthenticateUser.call(email: @email, password: @password)
    assert command.success?
    assert_not_nil command.result
    assert_instance_of Hash, command.result
    assert_not_nil command.result[:jwt]
  end
end
