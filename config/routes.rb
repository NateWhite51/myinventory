Inspeckd::Application.routes.draw do
  match '/payments/payment', :to => 'payments#payment', :as => 'paymentspayment', :via => [:get]
  match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]
  match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]
  resources :images
  resources :users do
    resources :accounts
    resource :customer do
      resources :credit_cards
      resource :subscription
    end
  end
  resources :credit_cards
  resources :payment_methods
  resources :properties do
    resources :rooms
  end
  resources :inspections do
    resources :images
    resources :inspected_rooms
    resources :inspection_details
  end
  resources :inspected_rooms do
    resources :images
    resources :inspected_features
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :inspection_details
  resources :messages
  resources :accounts do
    resources :images
  end
  resources :addresses
  resources :companies
  
  # Authorize.net stuff
  post '/submit_transaction', to: 'authorize_net#submit_transaction'
  
  post '/create_new_subscription', to: 'braintree#create_new_subscription'
  post '/add_card', to: 'braintree#add_card'
  get 'braintree_notification', :to => 'braintree#verify'
  post 'braintree_notification', :to => 'braintree#notify'
    
  
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/profile', to: 'users#edit'
  get '/support', to: 'static_pages#support'
  get '/toc', to: 'static_pages#toc'

  root 'static_pages#home'
end
