NinetyNineCats::Application.routes.draw do
  resource :session, only: [:new, :create]
  resources :users, only: [:new, :create]
  
#  root 'cats#index'
  resources :cats
  resources :cat_rental_requests
  patch "/cat_rental_requests/:id/approve" => "cat_rental_requests#approve", as: 'approve_request'
  patch "/cat_rental_requests/:id/deny" => "cat_rental_requests#deny", as: 'deny_request'
  delete "/session"  => "sessions#destroy", as: 'log_off'
  
end
