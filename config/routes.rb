Rails.application.routes.draw do
  resources :investments
  resources :companies

  get 'home/index'
  root to: 'home#index'

  get 'companies/:id/investments-on/:invested_id', to: 'companies#show_investments_on'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
