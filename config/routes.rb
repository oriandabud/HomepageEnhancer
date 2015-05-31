Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  resources :authenticate , only: [:show]

  resources :page_view , only: [:show]

  resources :recommendation, only: [:show]

end
