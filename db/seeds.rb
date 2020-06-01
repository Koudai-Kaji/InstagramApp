User.create!( name:      "Example user",
              user_name: "Exam",
              email:     "example@railstutorial.org",
              password:              "foobar",
              password_confirmation: "foobar",
              admin: true,
              introduce: "test " * 100)

99.times do |n|
  name = Faker::Name.name
  user_name = Faker::Name.name
  introduce = Faker::Lorem.sentence(5)
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(name:     name,
              user_name: user_name,
              introduce: introduce,
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


users = User.all
user  = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


user_images = UserImage.reorder(:created_at).take(5)
user = User.first
50.times do
  body = Faker::Lorem.sentence
  user_images.each do |user_image|
    user_image.comments.create(body: body, user_id: user.id)
  end
end



