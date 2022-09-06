Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  
  namespace :public do
    resources :posts, only:[:index, :show, :new, :create, :edit, :update]
    resources :users, only:[:show, :edit, :update]
    resources :comments, only:[:index, :new, :create, :show, :edit, :update]
  end
  
  namespace :admin do
    get "homes/top" => "homes#top"
    resources :sections, only:[:index, :edit, :create, :update]
    resources :exection_statuses, only:[:index, :edit, :create, :update]
  end
end
