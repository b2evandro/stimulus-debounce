# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :profiles, only: %i[index]
  # Defines the root path route ("/")
  root 'profiles#index'
end