Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  get 'home', to: 'home#index'
  
  resources :courses
  resources :sections
  resources :enrollments


  namespace :admin do
    get 'index', to: 'admin#index'
    get 'reload_catalog', to: 'admin#reload_catalog'
    post 'reload_catalog', to: 'admin#reload_catalog'
    get 'approve', to: 'admin#approve'
    post 'users/:id/approve', to: 'admin#approve', as: 'approve_user'
  end
end
