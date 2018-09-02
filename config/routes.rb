Rails.application.routes.draw do

  root :to => "urls#index"

  devise_for :users
  resources :urls

  namespace :api do
    namespace :v1 do
      resources :urls
    end
  end

  post "generate_api_key", to: "user_apis#create"
  get ":shortened_url", to: "urls#goto_url"

end
