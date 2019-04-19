# frozen_string_literal: true

# Verify a user token.
# input: http headers
# output: user record or nil
module V1
  module Commands
    class AuthorizeUserRequest
      prepend ::SimpleCommand

      attr_reader :headers

      def initialize(request = {})
        raise unless request.respond_to?(:headers)

        @headers = request.headers
      end

      def call
        user = User.find(decoded_token.fetch(:id)) if decoded_token
        user || errors.add(:token, "Invalid token") && nil
      end

      private def decoded_token
        @decoded_token ||= JsonWebToken.decode(encoded_token)
      end

      private def encoded_token
        if headers["Authorization"].present?
          # happy path: return a value
          headers["Authorization"].split(" ").last
        else
          # unhappy path: set an error and return nil
          errors.add(:token, "Missing token") && nil
        end
      end
    end
  end
end
