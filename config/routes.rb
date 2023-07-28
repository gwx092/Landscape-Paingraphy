Rails.application.routes.draw do
  #deviseのuser側ルーティング
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #deviseのadmin側ルーティング
  devise_for :admin,
    skip: [:registrations, :passwords] ,
    controllers: {
      sessions: "admin/sessions"
    }

  #ゲストログイン用ルーティング
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  #public側のルーティング
  scope module: :public do
    root to: 'homes#top'
    #タグのルーティング
    get '/post/tag/:name' => 'posts#tag'
    get '/post/tag' => 'posts#tag'
    get 'search' => 'searches#search'
    get 'searches/post_result'
    get 'searches/user_result'
    get 'searches/tag_result'
    resources :favorites, only: [:index]
    get 'follows/followings'
    get 'follows/followers'
    #users quit outのみresources :usersの上に記述しurlの誤認識を防ぐ(下にあるとquitがshowページ認識される)
    get '/users/quit', to: 'users#quit'
    patch '/users/out', to: 'users#out'
    resources :users, only: [:show, :edit, :update] do
      resource :follows, only: [:create, :destroy]
      get 'followings' => 'follows#followings', as: 'followings'
      get 'followers' => 'follows#followers', as: 'followers'
      member do
        get :favorites
      end
    end
    #重複回避のルーティング
    get '/users/information', to: 'users#show'
    get '/users/information/edit', to: 'users#edit'
    patch '/users/information', to: 'users#update'
    resources :posts, only: [:new, :create, :show, :index, :destroy] do
      resources :comments, only: [:create, :destroy]
      #id不要のルーティング
      resource :favorites, only: [:create, :destroy]
    end
  end


  #admin側のルーティング
  namespace :admin do
    get '' => 'homes#top'
    resources :users, only: [:show, :index, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
