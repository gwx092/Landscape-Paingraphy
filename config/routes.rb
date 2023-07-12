Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  
  #public側のルーティング
  scope module: :public do
    root to: 'homes#top'
    get 'searchees/post_result'
    get 'searchees/user_result'
    get 'searchees/tag_result'
    get 'favorites/index'
    get 'follows/followings'
    get 'follows/followers'
    get 'users/show'
    get 'users/edit'
    get 'users/quit'
    get 'sessions/new'
    get 'registrations/new'
  end
  #admin側のルーティング
  namespace :admin do
    get '' => 'homes#top'
    get 'users/show'
    get 'users/index'
    get 'users/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
