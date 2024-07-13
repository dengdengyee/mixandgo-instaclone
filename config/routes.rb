Rails.application.routes.draw do
  resources :posts, only: %i[create new] do
    resources :comments, only: %i[create new]
    resources :likes, only: :create do
      collection do
        delete :destroy
      end
    end
  end
  devise_for :users
  root 'site#index'
end
