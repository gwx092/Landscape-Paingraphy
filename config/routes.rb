Rails.application.routes.draw do
  #deviseのuser側ルーティング
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #deviseのadmin側ルーティング
  devise_for :admins,
    skip: [:registrations, :passwords] ,
    controllers: {
      sessions: "admin/sessions"
    }
    
  
  #public側のルーティング
  scope module: :public do
    root to: 'homes#top'
    get 'searches/post_result'
    get 'searches/user_result'
    get 'searches/tag_result'
    resources :favorites, only: [:index]
    get 'follows/followings'
    get 'follows/followers'
    resources :users, only: [:show, :edit]
    get '/users/quit', to: 'users#quit'
    patch '/users/out', to: 'users#out' 
    resources :posts, only: [:new, :create, :show, :index]
    #ゲストログイン用ルーティング
    post 'sessions/guest_sign_in', to: 'sessions#guest_sign_in'
  end
  #admin側のルーティング
  namespace :admin do
    get '' => 'homes#top'
    resources :users, only: [:show, :index, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
