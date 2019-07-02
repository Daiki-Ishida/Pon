Faker::Config.locale = :ja

20.times do
  name = Faker::Name.last_name
  User.create!(
    name: name,
    age:  Random.new.rand(18..65)
    )
end

20.times do
  name = Faker::Games::Pokemon.name
  age = Random.new.rand(0..6).to_s
  Ferret.create!(
    name: name,
    age:  age
  )
end
