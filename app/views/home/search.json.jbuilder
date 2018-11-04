json.listings do 
	json.array!(@listings_found) do |listing|
		json.name listing.title
		json.url listing_path(listing)
	end
end

json.users do 
	json.array!(@users_found) do |user|
		json.name user.name
		json.url user_path(user)
	end
end