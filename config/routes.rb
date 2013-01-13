OctopubWeb::Application.routes.draw do
  match "/auth/github/callback" => "sessions#create"

  resources :blogs

  root to: 'home#index'
end
