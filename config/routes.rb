Rails.application.routes.draw do
  resources :categories
  get 'users/edit'
  resources :users, only: [:update]
  get "perfil", to:"users#edit"
  resources :photos
  get 'my_photos',        to: 'photos#my_photos', as: 'my_photos'
  devise_for :users
  get 'home/index'
  resources :articles
  resources :comments
  get 'bienvenida', to:"home#index"
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
