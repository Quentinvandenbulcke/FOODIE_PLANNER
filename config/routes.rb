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
  resources :favorites, only: [:index]

  resources :meal_days, only: [:index, :destroy]
  resources :groceries, only: [:index, :show, :create, :destroy] do
    resources :grocery_deltas, only: [:update]
  end

  resources :grocery_lists, only: :destroy
end
