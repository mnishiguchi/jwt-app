# frozen_string_literal: true

require "test_helper"

class V1::UserRegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @email = "jimi@example.com"
    @password = "good-password"
    create(:user, email: @email, password: @password)
  end

  test "with invalid params" do
    post v1_user_registration_url
    assert_response :unauthorized

    post v1_user_registration_url, params: {
      auth: { email: "invalid",
              password: "abc",
              password_confirmation: "xyz" }
    }
    assert_response :unauthorized
  end

  test "with valid params" do
    post v1_user_registration_url, params: {
      auth: { email: @email,
              password: @password,
              password_confirmation: @password }
    }
    assert_response :success
  end
end
