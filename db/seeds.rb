
# Create 100 Fake users. Also Template in how we can prepopulate the database.
User.create!(name:  "admin",
             email: "admin@admin.com",
             password:              "admin",
             password_confirmation: "admin",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             person: Person.create(
              address: Faker::Address.street_address,
              phone_number: '6471678732',
              description: 'I am a bot created by the master Peter Tanugraha'
             ))

99.times do |n|
  name  = Faker::FunnyName.name
  email = "example-#{n+1}@beepbeep.org"
  password = "worstpassword"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               person: Person.create(
                address: Faker::Address.street_address,
                phone_number: '6471678732',
                description: 'I am a bot created by the master Peter Tanugraha'
               ))
end