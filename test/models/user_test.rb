# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "default factory" do
    user = build(:user)
    assert user.valid?
  end

  test "validates length of username" do
    invalid_username = "a" * 51
    user = build(:user, username: invalid_username)
    assert_not user.valid?
  end

  test "validates presence of email" do
    user = build(:user, email: nil)
    assert_not user.valid?
  end

  test "validates uniqueness of email" do
    email = "jimi@example.com"
    create(:user, email: email)
    user = build(:user, email: email.upcase)
    assert_not user.valid?
  end

  test "validates format of email" do
    invalid_email = "jimi-example-com"
    user = build(:user, email: invalid_email)
    assert_not user.valid?
  end

  test "validates length of password" do
    invalid_password = "abc"
    user = build(:user, password: invalid_password)
    assert_not user.valid?
  end
end
