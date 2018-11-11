json.groups do 
	json.array!(@add_to_groups_found) do |user|
		json.name user.name
		json.url user_path(user)
	end
end