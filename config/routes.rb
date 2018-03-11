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
  get 'activity/:id', to: 'pages#activity', as: 'activity'
  get 'refresh', to: 'activities#refresh', as: 'refresh_activities'
  root to: "pages#home"
end
