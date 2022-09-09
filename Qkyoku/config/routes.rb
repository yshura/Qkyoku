Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  namespace :public do
    patch '/withdrawal'=>'users#withdrawal'
    get '/unsubscribe'=>'users#unsubscribe'
    resources :sections, only: [:show]
    resources :users, only:[:index, :show, :edit, :update] do
      resources :favorites, only: [:index]
      resources :comments, only: [:index]
    end
    resources :posts do
      collection do
        get 'search'
      end
      resources :comments, only: [:new, :edit, :show, :create, :update, :destroy] do 
        resources :favorites, only: [:create, :destroy]
      end
    end
    
  end
  
  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :sections, only:[:index, :edit, :create, :update]
    resources :execution_statuses, only:[:index, :edit, :create, :update]
    resources :users, only:[:index, :show, :edit, :update]
  end
end
