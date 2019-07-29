Faker::Config.locale = :ja

30.times do
  kanji_firstname = Faker::Name.first_name
  kanji_lastname = Faker::Name.last_name
  name = Faker::Games::Pokemon.name
  introduction = Faker::Lorem.paragraph(4)
  birth_date = Faker::Date.birthday(18, 65)
  email = Faker::Internet.email
  random = Random.new()

  User.create!(kanji_firstname: kanji_firstname,
               kanji_lastname: kanji_lastname,
               kana_firstname: 'テスト',
               kana_lastname: 'タロウ',
               name: name,
               postal_code: random.rand(1000000..9999999),
               postal_address: '東京都千代田区千代田１−１',
               introduction: introduction,
               gender: random.rand(1..2),
               birth_date: birth_date,
               latitude: random.rand(33..37),
               longitude: random.rand(130..140),
               territory: random.rand(5..20),
               status: random.rand(1..2),
               email: email,
               password_digest: User.digest('password'),
               activated: true,
               activated_at: Time.zone.now
             )
end

40.times do
  name = Faker::Creature::Dog.name
  character = Faker::Lorem.word
  introduction = Faker::Lorem.paragraph(4)
  birth_date = Faker::Date.birthday(0, 7)
  random = Random.new()

  Ferret.create!(
    name: name,
    character: character,
    introduction: introduction,
    birth_date: birth_date,
    gender: random.rand(1..2),
    user_id: random.rand(1..25)
  )
end

20.times do
  content = Faker::Lorem.paragraph(4)
  random = Random.new()

  Post.create!(
    content: content,
    user_id: random.rand(1..25)
  )
end


20.times do
  random = Random.new()

  Relationship.create!(
    follower_id: random.rand(1..15),
    followed_id: random.rand(16..30)
  )
end

60.times do
  random = Random.new()
  
  Like.create!(
    user_id: random.rand(1..30),
    post_id: random.rand(1..20)
  )
end
