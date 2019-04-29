# frozen_string_literal: true

module V1
  class UserTokensController < V1::ApplicationController
    skip_before_action :authorize_user_request

    # Log in a registered user
    # POST /v1/user_token
    def create
      command = V1::Commands::AuthenticateUser.call(
        email: params.dig(:auth, :email),
        password: params.dig(:auth, :password)
      )

      if command.success?
        # render json: command.result, status: :created
        render_success_json(:created, result: command.result)
      else
        render_failure_json(:unauthorized)
      end
    end
  end
end
