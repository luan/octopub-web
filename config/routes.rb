OctopubWeb::Application.routes.draw do
  match "/auth/github/callback" => "sessions#create"

  root to: 'home#index'
end
