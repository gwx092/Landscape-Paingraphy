class Public::SessionsController < ApplicationController
  def new
  end
  
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    posts_path
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
