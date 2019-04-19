# frozen_string_literal: true

# Verifies user credentials.
# input: email, password (user credentials)
# output: jwt that container user info or nil
module V1
  module Commands
    class AuthenticateUser
      prepend ::SimpleCommand

      def initialize(email:, password:)
        @email = email.to_s
        @password = password.to_s
      end

      # schema of jwt payload
      Payload = Struct.new(:id, :email, :username, :avatar)

      # mandatory: define a #call method.
      # its return value will be available through #result.
      # https://github.com/nebulab/simple_command
      def call
        authenticated_user = find_and_authenticate_user
        if authenticated_user
          # happy path: return a value
          payload = Payload.new(authenticated_user.id,
                                authenticated_user.email,
                                authenticated_user.username,
                                authenticated_user.avatar)
          JsonWebToken.encode(payload.to_h)
        else
          # unhappy path: set an error and return nil
          errors.add(:user_authentication, "Invalid credentials")
          nil
        end
      end

      private def find_and_authenticate_user
        user = User.find_by(email: @email)
        user if user&.authenticate(@password)
      end
    end
  end
end
