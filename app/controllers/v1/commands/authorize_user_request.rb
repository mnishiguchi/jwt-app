# frozen_string_literal: true

# Verify a user token.
# input: http headers
# output: logged-in user record or nil
module V1
  module Commands
    class AuthorizeUserRequest
      prepend ::SimpleCommand

      attr_reader :headers

      def initialize(request = {})
        raise unless request.respond_to?(:headers)

        @headers = request.headers
      end

      # mandatory: define a #call method.
      # its return value will be available through #result.
      # https://github.com/nebulab/simple_command
      def call
        current_user
      end

      # Logged-in user or nil
      private def current_user
        return unless decoded_token

        User.find(decoded_token.fetch(:id)) || errors.add(:token, "Invalid token")
      end

      private def decoded_token
        @decoded_token ||= JsonWebToken.decode(jwt_from_http_request) ||
                           errors.add(:token, "Invalid token")
      end

      private def jwt_from_http_request
        @jwt_from_http_request ||= begin
          if headers["Authorization"].present?
            # happy path: return a value
            headers["Authorization"].split(" ").last
          else
            # unhappy path: set an error and return nil
            errors.add(:token, "Missing token")
          end
        end
      end
    end
  end
end
