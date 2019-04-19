# frozen_string_literal: true

module V1
  class UserTokenController < V1::ApplicationController
    skip_before_action :authorize_user_request

    # POST /v1/user_token
    def create
      command = V1::Commands::AuthenticateUser.call(
        email: params.dig(:auth, :email),
        password: params.dig(:auth, :password)
      )

      if command.success?
        jwt =  command.result
        render json: { jwt: jwt }, status: :created
      else
        render_unauthorized
      end
    end
  end
end
