class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  #before_action :set_user, only: [:show, :favorites, :comments, :destroy]

  def show
    #ログイン中のユーザーidを取得し、@userへ格納
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def edit
    @user = User.find(current_user.id)

  end

  def update
     @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root 
  end

  def quit
  end

  def out
    @user = User.find(current_user.id)
    #ユーザーのステータスをtrue(退会状態)へ変更
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    #ユーザーidがユーザーのいいねとそのpost_idを取得し、favoritesに代入
    #pluckはFavoriteモデルのpost_idカラムの一覧を持ってくる
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:family_name, :nickname, :email, :is_deleted, :profile_image)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end
