# frozen_string_literal: true

module V1
  class ApplicationController < ActionController::Base
    rescue_from StandardError, with: :render_unauthorized
    skip_before_action :verify_authenticity_token
    before_action :authorize_user_request

    attr_reader :current_user

    private def authorize_user_request
      @current_user = V1::Commands::AuthorizeUserRequest.call(request).result
      render_unauthorized unless @current_user
    end

    protected def render_unauthorized(exception)
      head :unauthorized
      Rails.logger.error(exception)
    end
  end
end
