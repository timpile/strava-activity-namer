Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    },
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
  resources :activities, only: [:index, :show]
  get 'refresh', to: 'activities#refresh', as: 'refresh_activities'
  get 'set_name/:id', to: 'activities#set_name', as: 'set_name'
  get 'refresh/:id', to: 'laps#refresh', as: 'refresh_laps'
  root to: "pages#home"
end
