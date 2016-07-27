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

10.times do |n|
  name = Faker::Name.name
  descriptions  = "abc-#{n+1}-cba"
  number = Faker::Number.digit
  Category.create!(category_name: name,
    descriptions: descriptions)
end

12.times do |n|
  name = Faker::Lorem.words(4).map(&:capitalize).join(' ')
  author_name = Faker::Name.name
  date = Faker::Date.between(10.years.ago, 5.years.ago).to_date
  page_number = Faker::Number.between 100, 1000
  category = Faker::Number.between 1, 5
  description = Faker::Lorem.paragraphs.join(' ')
  Book.create!(title: name,
    author: author_name,
    publish_date: date,
    number_of_page: page_number,
    category_id: category,
    description: description
  )
end

# Following relationships
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..20]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
