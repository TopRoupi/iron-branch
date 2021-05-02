# frozen_string_literal: true

Rails.application.routes.draw do
  resources :investments, except: [:index, :edit, :update]
  resources :companies do
    get :autocomplete_company_name, on: :collection
    get :autocomplete_company_cnpj, on: :collection
  end

  get "home/index"
  root to: "home#index"
  get "companies/:id/investments-on/:invested_id", to: "companies#show_investments_on"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
