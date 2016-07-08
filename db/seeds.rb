User.create!(name:  "admin",
  email: "admin@example.com",
  password: "abc123",
  password_confirmation: "abc123",
  is_admin: true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
