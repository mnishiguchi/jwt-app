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

      # mandatory: define a #call method.
      # its return value will be available through #result.
      # https://github.com/nebulab/simple_command
      def call
        jwt_json
      end

      private def jwt_json
        return unless authenticated_user

        payload = { id: authenticated_user.id,
                    email: authenticated_user.email,
                    username: authenticated_user.username,
                    avatar: authenticated_user.avatar }
        { jwt: JsonWebToken.encode(payload) }
      end

      private def authenticated_user
        @authenticated_user ||= begin
          user = User.find_by(email: @email)
          if user&.authenticate(@password)
            # happy path: return a value
            user
          else
            # unhappy path: set an error and return nil
            errors.add(:user_authentication, "Invalid credentials")
          end
        end
      end
    end
  end
end
