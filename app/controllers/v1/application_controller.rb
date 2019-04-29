# frozen_string_literal: true

module V1
  class ApplicationController < ActionController::Base
    rescue_from StandardError do |_exception|
      render_failure_json :unauthorized
    end
    skip_before_action :verify_authenticity_token
    before_action :authorize_user_request

    attr_reader :current_user

    private def authorize_user_request
      @current_user = V1::Commands::AuthorizeUserRequest.call(request).result
      render_failure_json(:unauthorized) unless @current_user
    end

    protected def render_success_json(status_symbol, opts = {})
      status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status_symbol.to_sym] || 200
      message = opts[:message] || Rack::Utils::HTTP_STATUS_CODES[status_code]
      render(
        status: status_code,
        json: { code: status_code,
                result: opts[:result] || { message: message } }
      )
    end

    protected def render_failure_json(status_symbol, opts = {})
      status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status_symbol.to_sym] || 500
      message = opts[:message] || Rack::Utils::HTTP_STATUS_CODES[status_code]
      render(
        status: status_code,
        json: { error: { code: status_code, message: message } }
      )
    end
  end
end
