Rails.application.routes.draw do
  root to: 'plaid#new'
  resources :plaid
  resource :banks
  resources :payments
  resources :microdeposits
end
