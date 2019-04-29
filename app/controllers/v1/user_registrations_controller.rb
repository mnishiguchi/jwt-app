# frozen_string_literal: true

module V1
  class UserRegistrationsController < V1::ApplicationController
    skip_before_action :authorize_user_request

    # TODO: handle "already-registered"
    # Register in a new user
    # POST /v1/user_registration
    def create
      render_failure_json(:not_modified) && return if User.where(email: user_registration_params[:email]).exists?

      user = User.create(
        email: user_registration_params.dig(:email),
        password: user_registration_params.dig(:password),
        password_confirmation: user_registration_params.dig(:password_confirmation)
      )

      render_failure_json(:unauthorized) && return unless user.valid?

      # TODO: pass user as an argument
      command = V1::Commands::AuthenticateUser.call(
        email: user.email,
        password: user.password
      )

      if command.success?
        # render json: command.result, status: :created
        render_success_json(:created, result: command.result)
      else
        render_failure_json(:unauthorized)
      end
    end

    private def user_registration_params
      params.require(:auth).permit(:username, :email, :avatar, :password, :password_confirmation)
    end
  end
end
