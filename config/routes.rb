Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }#, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  get '/auth/:provider/callback', to: 'sessions#create'
  root to: "pages#home"
end
