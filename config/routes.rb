# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :v1 do
    post "user_token" => "user_token#create"
    resource :user, only: [:create, :show]
  end

  root to: "pages#home"
end
