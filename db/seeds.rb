User.create!(name:  "Example User",
             username: "exampleusername",
             email: "mrexample@example.com",
             password:              "password12",
             password_confirmation: "password12",
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
