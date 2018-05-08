Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end

  get 'products', to: 'home#get_products'
  get 'products/update/:id/:type', to: 'home#update_products'
  get 'products/favorites', to: 'home#favorite_products'
  get 'favorites', to: 'home#favorites'
end
