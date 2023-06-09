Rails.application.routes.draw do
  get 'groceries/new'
  get 'day_meals/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, only: [:index, :show, :create] do
    resources :meal_days, only: :create
    resources :favorites, only: [:create, :destroy]
  end
  resources :favorites, only: [:show]

  resources :meal_days, only: :index
  resources :groceries, only: [:show, :new, :create]
end
