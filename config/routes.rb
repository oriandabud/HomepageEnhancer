Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  resources :websites do

    resources :authenticate , only: [:show] , param: :uuid

    resources :page_view , only: [:create]

    resources :recommendation, only: [:index]
  end
end
