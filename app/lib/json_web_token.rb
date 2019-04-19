# frozen_string_literal: true

# https://github.com/jwt/ruby-jwt
class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key)
    rescue StandardError
      nil
    end

    def decode(token)
      payload, _header = JWT.decode(token, secret_key)
      ActiveSupport::HashWithIndifferentAccess.new(payload)
    rescue StandardError
      nil
    end

    def secret_key
      Rails.application.secrets.secret_key_base
    end
  end
end
