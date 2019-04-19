# frozen_string_literal: true

module V1
  class UsersController < V1::ApplicationController
    before_action :authenticate_user

    def show
      render json: "hello"
    end
  end
end
