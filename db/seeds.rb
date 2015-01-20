User.create!(name:  "Example User",
             username: "exampleusername",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  username = Faker::Name.name
  email = "example-#{n+1}@gmail.org"
  password = "password"
  User.create!(name:  name,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end