# frozen_string_literal: true

module V1
  class ApplicationController < ActionController::Base
    # rescue_from StandardError, with: :render_unauthorized
    skip_before_action :verify_authenticity_token
    before_action :authorize_user_request

    attr_reader :current_user

    private def authorize_user_request
      @current_user = V1::Commands::AuthorizeUserRequest.call(request).result
      render_unauthorized unless @current_user
    end

    private def render_unauthorized
      head :unauthorized
    end

    private def render_not_found
      head :not_found
    end
  end
end
