Rails.application.routes.draw do
  
  root 'home#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  get 'home', to: 'home#index'
  
  resources :courses do 
    member do 
      get :confirm_destroy
    end
  end
  resources :sections do
    member do 
      get :confirm_destroy
    end
  end
  resources :enrollments
  resources :grader_applications
  resources :recommendations

  namespace :admin do
    get 'index', to: 'admin#index'
    get 'reload_catalog', to: 'admin#reload_catalog'
    post 'reload_catalog', to: 'admin#reload_catalog'
    get 'approve', to: 'admin#approve'
    post 'users/:id/approve', to: 'admin#approve', as: 'approve_user'
  end

# Route for undefined paths
match '*path', to: 'application#not_found', via: :all
end

