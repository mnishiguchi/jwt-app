# frozen_string_literal: true

require "test_helper"

class JwtAuthenticationTest < ActionDispatch::IntegrationTest
  test "authenticate user" do
    # simulate a registered user
    create(:user, email: "example@mail.com", password: "123123123", password_confirmation: "123123123")

    # get jwt
    post v1_user_token_path, params: { auth: { email: "example@mail.com", password: "123123123" } }
    assert_response :success
    parsed_body = JSON.parse(response.body)
    jwt = parsed_body.fetch("jwt")
    assert_not_empty jwt

    # access resource with no jwt
    get v1_user_path
    assert_response :unauthorized

    # access resource with valid jwt
    get v1_user_path, headers: { "Authorization" => "Bearer #{jwt}" }
    assert_response :success
  end
end
