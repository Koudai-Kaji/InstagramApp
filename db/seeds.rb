User.create!( name:      "Example user",
              user_name: "Exam",
              email:     "example@railstutorial.org",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true)

5.times do |n|
  name = Faker::Name.name
  user_name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(name:      name,
              user_name: user_name,
              email:     email,
              password:              password,
              password_confirmation: password)
end


users = User.order(:created_at).take(6)
50.times do
  users.each do |user|
    user.user_images.create!(picture: open("test/fixtures/image2.png", "r"))
  end
end




