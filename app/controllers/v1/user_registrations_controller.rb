# frozen_string_literal: true

module V1
  class UserRegistrationsController < V1::ApplicationController
    skip_before_action :authorize_user_request

    # TODO: handle "already-registered"
    # Register in a new user
    # POST /v1/user_registration
    def create
      render_unauthorized unless User.create(user_registration_params)

      command = V1::Commands::AuthenticateUser.call(
        email: params.dig(:auth, :email),
        password: params.dig(:auth, :password)
      )

      if command.success?
        render json: command.result, status: :created
      else
        render_unauthorized
      end
    end

    private def user_registration_params
      params.require(:auth).permit(:username, :email, :avatar, :password, :password_confirmation)
    end
  end
end
