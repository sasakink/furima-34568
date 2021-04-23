Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  get 'items/search'
  resources :items do
    resources :purchases, only: [:create, :index]
    # collection do
      # get 'search'
    # end
    resources :comments, only: :create
  end
end
