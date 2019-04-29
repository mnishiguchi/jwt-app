# frozen_string_literal: true

require "test_helper"

class JwtAuthenticationTest < ActionDispatch::IntegrationTest
  test "sign up a new user" do
    params = { auth: { email: "jhendrix@example.com",
                       password: "123123123",
                       password_confirmation: "123123123" } }
    post v1_user_registration_path, params: params
    assert_response :success
    assert_equal 1, User.count
  end

  test "log in a registered user" do
    # simulate a registered user
    create(:user, email: "jhendrix@example.com", password: "123123123", password_confirmation: "123123123")

    # get jwt
    post v1_user_token_path, params: { auth: { email: "jhendrix@example.com", password: "123123123" } }
    assert_response :success

    parsed_body = JSON.parse(response.body)
    jwt = parsed_body.dig("result", "jwt")
    assert_not_empty jwt

    # access resource with no jwt
    get v1_user_path
    assert_response :unauthorized

    # access resource with valid jwt
    get v1_user_path, headers: { "Authorization" => "Bearer #{jwt}" }
    assert_response :success
  end
end
