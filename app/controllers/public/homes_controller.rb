class Public::HomesController < ApplicationController
  def top
    #@posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def guest_sign_in
    #ゲストユーザーを探すor作成するメソッド
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
    #パスワードをランダムで設定
      user.password = SecureRandom.urlsafe_base64
    #not nullの項目を設定
      user.family_name = "ゲスト"
      user.nickname = "ゲストさん"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
