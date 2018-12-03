def geo_code(address) 
  results = Geocoder.search(address)
  lat = nil
  lon = nil
  if results.first
    lat = "#{results.first.coordinates[0]}"
    lon = "#{results.first.coordinates[1]}"
  end
  return [lat,lon]
end

def seed_listing(title, description, category, userid, image_name, image_type, address)
  listing = Listing.new
  listing.title = title
  listing.description = description
  listing.category = category
  listing.start_lending = Faker::Date.forward(1)
  listing.end_lending = Faker::Date.forward(365)
  listing.user_id = userid
  listing.images.attach(
      io: File.open(File.join(Rails.root, ("/app/assets/images/"+image_name))),
      filename: image_name,
      content_type: image_type,
  )
  listing.address = address
  lat_long = geo_code(listing.address)
  listing.latitude = lat_long[0]
  listing.longitude = lat_long[1]
  if listing.save
    puts "LISTINGS: Successfully created Listing id: #{listing.id} with user_id: #{listing.user_id}"
  else
    listing.errors.full_messages.each do |message|
    puts message
    end
  end
end

def seed_user (name, email, pw, addr, desc, image_name, image_type)
  @temp_user = User.new(name:  name,
             email: email,
             password:              pw,
             password_confirmation: pw,
             admin: false,
             activated: true,
             activated_at: Time.zone.now,
             person: Person.create(
             address: addr,
             phone_number: Faker::PhoneNumber.cell_phone,
             description: desc
             ))
  @temp_user.person.image.attach(
      io: File.open(File.join(Rails.root, ("/app/assets/images/"+image_name))),
      filename: image_name,
      content_type: image_type,
  )
  @temp_user.save
end


Given("that I am able to login as `cucumber_tester` and view my dashboard") do
  normal_user = User.new(name:  "cucumber_tester",
								 email: "valid_user@gmail.com",
					             password:              "111111",
					             password_confirmation: "111111",
					             activated: true,
					             activated_at: Time.zone.now,
					             person: Person.create(
					              address: Faker::Address.street_address,
					              phone_number: '6471678732',
					              description: 'I am a bot created by the master Peter Tanugraha'
					             ))
		normal_user.save
		Notification.create(recipient: normal_user,actor: normal_user,action:"created_new_account",notifiable:normal_user)
		visit root_path
    sleep(2)
		click_link 'loginHomeButton'
    sleep(2) #for the javascript tester to work
    within('#loginModal') do 
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        fill_in 'session_email', with: 'valid_user@gmail.com'
        fill_in 'session_password', with: '111111'
        click_button 'Log in'
      end
    sleep(4)
    within(".xchange-header") do 
        expect(page).to have_content('cucumber_tester')
    end
end

Given("that I already have listings and other users seeded") do
  seed_user("Arash", "arash@gmail.com", "12345", "262 Rhodes Ave Toronto", 'Developer at XChange',"arash.jpg", 'image/jpeg')
  seed_user("Peter", "peter@gmail.com", "12345", "15 Pape Ave Toronto", 'Developer at XChange','peter.jpeg', 'image/jpeg')
  seed_user("Maru", "maru@gmail.com", "12345", "1830 Bloor St W Toronto", 'Developer at XChange','maru.jpg', 'image/jpeg')
  seed_user("Adi", "adi@gmail.com", "12345", "260 Carlaw Ave Toronto", 'Developer at XChange','adi.jpeg', 'image/jpeg')
  seed_user("Arnav", "arnav@gmail.com", "12345", "62 Hiltz Ave Toronto", 'Developer at XChange','arnav.jpg', 'image/jpeg')
  seed_user("KC", "KC@gmail.com", "12345", "67 Curzon St Toronto", 'Developer at XChange', 'KC.jpg', 'image/jpeg')
  seed_user("Donald Trump", "trump@gmail.com", "12345", "156 Colbeck St Toronto", 'President of the United States', 'trump.jpg', 'image/jpeg')
  seed_user("Neil deGrasse Tyson", "neil@gmail.com", "12345", "65 High Park Ave Toronto", 'The Space Guy', 'neil.jpg', 'image/jpeg')
  seed_user("Chandler Bing", "chandler@gmail.com", "12345", "2 Aberfoyle Cres Toronto", "I'm not great at advice. Can I interest you in a sarcastic comment?", 'chandler.png', 'image/jpeg')
  seed_user("Donald Knuth", "donald@gmail.com", "12345", "52 Milverton Blvd Toronto", "An algorithm must be seen to be believed.", 'donald.jpg', 'image/jpeg')
  # Seeding Listings
  seed_listing("Canon FX Camera", "35 mm SLR Camera", "Film & Photography", User.find_by(name:"Arash").id, 'camera-seed.jpeg', 'image/jpeg', "710 Trethewey Dr Toronto")
  seed_listing("Saw", "Traditional style saw for carpenting.", "Home / Office / Garden", User.find_by(name:"Peter").id, 'saw.jpg', 'image/jpeg', "2925 Dufferin St Toronto")
  seed_listing("HP Office Printer", "Not used. Message for details", "Home / Office / Garden", User.find_by(name:"Adi").id, 'printer.jpg', 'image/jpeg', "36 Thorncliffe Ave Toronto")
  seed_listing("Drone with Camera", "Comes with a 4K Camera", "Drones", User.find_by(name:"Arnav").id, 'drone.jpg', 'image/jpeg', "1830 Bloor St W Toronto")
  seed_listing("DJ studio", "Available for daily rentals", "DJ Equipment", User.find_by(name:"Maru").id, 'dj.jpg', 'image/jpeg', "82 Woodside Ave Toronto")
  seed_listing("Bicycle", "Sport. Never used.", "Sports", User.find_by(name:"KC").id, 'bike.jpeg', 'image/jpeg', "111 Pacific Ave Toronto")
  seed_listing("Trump's Tower", "My humble tower.", "Holiday & Travel", User.find_by(name:"Donald Trump").id, 'tower.jpg', 'image/jpeg', "325 Bay St, Toronto")
  seed_listing("Cosmos DVD set", "My very own TV show", "Film & Photography", User.find_by(name:"Neil deGrasse Tyson").id, 'cosmos.jpg', 'image/jpeg', "81 Lemonwood Dr Toronto")
  seed_listing("OLD Home Phone", "Old collectible", "Home / Office / Garden", User.find_by(name:"Chandler Bing").id, 'phone.png', 'image/png', "103 The Queensway Toronto")
  seed_listing("The Art of Computer Programming", "Collection by Donald Knuth", "Home / Office / Garden", User.find_by(name:"Donald Knuth").id, 'dbook.jpg', 'image/jpg', "989 Logan Ave Toronto")
end

When("I click listings in the top header") do
  within(".xchange-header") do 
    expect(page).to have_content("Listings")
    click_link 'Listings'
  end
end

Then("I should see an item `saw` as it was already previously seeded") do 
  sleep(3)
  within("#listingsObjectDivUniqueId") do
    expect(page).to have_content('Saw')
  end
end

Then("I should see an item `HP Office Printer` as it was already previously seeded") do
  within(".container-fluid") do 
    expect(page).to have_content('HP Office Printer')
  end
end

When("I click the button view listing to view the item saw") do
  click_button 'saw' #I've made an ID for each button containing the title of the item .. Its okay for now
end

Then("I should be able to see descriptive information about the saw") do
  within(".container-fluid") do 
    expect(page).to have_content("Traditional style saw for carpenting")
  end
end

Then("Who is lending the item") do
  within(".container-fluid") do 
    expect(page).to have_content("Who's lending this out?")
  end
end

Then("The rating of the lender of the item") do
  within(".container-fluid") do
    expect(page).to have_content("Rating:")
  end
end
