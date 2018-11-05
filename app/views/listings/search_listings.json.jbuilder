json.listings do 
	json.array!(@listings_found) do |listing|
		json.title listing.title
		json.url listing_path(listing)
	end
end