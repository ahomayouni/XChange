
# Create 100 Fake users. Also Template in how we can prepopulate the database.
User.create!(name:  "admin",
             email: "admin@admin.com",
             password:              "admin",
             password_confirmation: "admin",
             admin: true)

99.times do |n|
  name  = Faker::FunnyName.name
  email = "example-#{n+1}@beepbeep.org"
  password = "worstpassword"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end