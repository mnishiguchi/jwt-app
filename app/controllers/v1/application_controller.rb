# frozen_string_literal: true

module V1
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    include ::Knock::Authenticable
  end
end