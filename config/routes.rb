require 'api_constraints'

YalanticImageApi::Application.routes.draw do
  # resources :galleries
  # root to: "galleries#new"
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users

  namespace :api, defaults: { format: :json } do

    
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :sessions, :only => [:create, :destroy]
      controller :galleries do
        post 'resize' => :resize_image
        post 'resize_old' => :resize_old_image
        get  'show_all_images' => :show_all_images
      end
      
      controller :users do
        post    'users/create'  => :create
        patch   'users/update'  => :update
        delete  'users/delete' => :delete
      end

    end
  end
end
