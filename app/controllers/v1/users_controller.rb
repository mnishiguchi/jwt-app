# frozen_string_literal: true

module V1
  class UsersController < V1::ApplicationController
    # Logged-in user's profile
    # GET /v1/user
    def show
      # TODO: implement
      render json: "hello"
    end
  end
end
