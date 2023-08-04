class Public::HomesController < ApplicationController
  def top
    #@posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|#ゲストユーザーを探すor作成するメソッド
      user.password = SecureRandom.urlsafe_base64#パスワードをランダムで設定
      user.family_name = "ゲスト"#not nullの項目を設定
      user.nickname = "ゲストさん"#not nullの項目を設定
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
