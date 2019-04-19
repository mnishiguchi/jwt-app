# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :username, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
end
