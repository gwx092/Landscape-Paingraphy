class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  #フォローしたされたの記述
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  #throughでスルーするテーブル、sourceで参照するカラムを指定
  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :reverse_of_follows, source: :follower
  #バリデーション
  validates :family_name, presence: true
  validates :nickname, presence: true

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローしたときの処理
  def follow(user_id)
    follows.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.guest
    #ゲストユーザーを探すor作成するメソッド
    find_or_create_by!(email: 'guest@example.com') do |user|
    #パスワードをランダムで設定
      user.password = SecureRandom.urlsafe_base64
    #not nullの項目を設定
      user.family_name = "ゲスト"
      user.nickname = "ゲストさん"
    end
  end

  #検索条件分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("nickname LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("nickname LIKE?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("nickname LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end
end
