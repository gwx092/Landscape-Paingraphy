class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def update
     @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path
    else
      redirect_to edit_user_path
    end
  end
  
  def destroy
  end
  
  def quit
  end
  
  def out
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:family_name, :nickname, :email, :is_deleted)
  end
end
