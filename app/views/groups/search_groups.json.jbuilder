json.groups do 
	json.array!(@groups_found) do |groups|
		json.name groups.name
		json.url group_path(groups)
	end
end