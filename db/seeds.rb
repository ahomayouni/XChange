User.create!(name:  "Michael Stumm",
             email: "example@michaelstumm.com",
             password:              "aaaaaa",
             password_confirmation: "aaaaaa")

99.times do |n|
  name  = Faker::FunnyName.name
  email = "example-#{n+1}@beepbeep.org"
  password = "worstpassword"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end