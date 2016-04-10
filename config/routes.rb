require 'api_constraints'

YalanticImageApi::Application.routes.draw do

  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create]
      resources :sessions, :only => [:create, :destroy]
    end
  end
end
