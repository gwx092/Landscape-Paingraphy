class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.guest
    #ゲストユーザーを探すor作成するメソッド
    find_or_create_by!(email: 'guest@example.com') do |user|
    #パスワードをランダムで設定
      user.password = SecureRandom.urlsafe_base64
      user.family_name = "ゲスト"
      user.nickname = "ゲスト"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
end
