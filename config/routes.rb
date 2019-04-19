# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :v1 do
    resource :user_registration, only: :create
    resource :user_token, only: :create
    resource :user, only: :show
  end

  root to: "pages#home"
end
