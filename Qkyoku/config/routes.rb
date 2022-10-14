Rails.application.routes.draw do
  get 'workplaces/index'
  get 'workplaces/edit'
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
    get '/about'=>'homes#about'
    patch '/withdrawal'=>'users#withdrawal'
    get '/unsubscribe'=>'users#unsubscribe'
    resources :sections, only: [:show]
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
    resources :users, only:[:index, :show, :update] do
      resources :favorites, only: [:index]
      resources :comments, only: [:index]
      resources :notifications, only: [:index]
    end
    resources :posts do
      collection do
        get 'search'
      end
      resources :comments, only: [:new, :edit, :create, :update, :destroy] do 
        resources :favorites, only: [:create, :destroy]
      end
    end
  end
  
  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :posts, only: [:index, :show, :destroy]
    resources :sections, only:[:index, :edit, :create, :update, :destroy]
    resources :execution_statuses, only:[:index, :edit, :create, :update, :destroy]
    resources :workplaces, only:[:index, :edit, :create, :update, :destroy]
    resources :users, only:[:index, :show, :edit, :update] do
      resources :comments, only: [:index,:destroy]
    end
  end
end
