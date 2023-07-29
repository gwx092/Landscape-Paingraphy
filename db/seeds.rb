# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'aaaaaa'
)

users = User.create!(
  [
    {email: 'toyota@example.com', family_name: '豊田　太郎', nickname: 'トヨタ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'matsuda@example.com', family_name: '松田　清', nickname: 'マツダ',password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'suzuki@example.com', family_name: '鈴木　一郎', nickname: 'スズキ',password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

Post.create!(
  [
    {title: '桂浜の海', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), body: '#海#高知#桂浜#海水浴　高知桂浜の海に行きました。', user_id: users[0].id },
    {title: '富士山', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), body: '#富士山#山#静岡#山梨　富士山へ行ってきました！', user_id: users[1].id },
    {title: '飛行機からの景色', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), body: '#空#静岡#高知#飛行機　静岡から高知へ飛行機に乗った際の景色！', user_id: users[2].id }
  ]
)

Comment.create!(
  [
    {user_id: 1, post_id: 2, comment: '絶景ですね！' },
    {user_id: 2, post_id: 3, comment: '旅行ですか？うらやましいです！'},
    {user_id: 3, post_id: 1, comment: '海水浴気持ちよさそう！' }
  ]
)

Follow.create!(
  [
    {follower_id: 2, followed_id: 3 },
    {follower_id: 3, followed_id: 1 },
    {follower_id: 1, followed_id: 2 }
  ]
)

PostTag.create!(
  [
    {post_id: 1, tag_id: 1 },
    {post_id: 2, tag_id: 2 },
    {post_id: 3, tag_id: 3 }
  ]
)

Favorite.create!(
  [
    {user_id: 1, post_id: 2 },
    {user_id: 2, post_id: 3 },
    {user_id: 3, post_id: 1 }
  ]
)
