Rails.application.routes.draw do
  resources :statuses
  root to: 'welcome#index'
  get 'welcome/index'
  

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  
  resources :admins
  resources :instructors do
    resources :templates
    resources :students do
      resources :lessons do
        resources :entries
        resources :comms
      end
    end
  end

  get 'instructors/:id/settings', to: 'instructors#settings', as: 'settings'
  get 'instructors/:id/settings/archive', to: 'instructors#archives', as: 'archives'
  get 'instructors/:id/settings/templates', to: 'instructors#templates', as: 'templates'
  post 'instructors/:id', to: 'students#status', as: 'toarchive'
  post 'instructors/:id/settings', to: 'students#status', as: 'fromarchive'
  # 
end
