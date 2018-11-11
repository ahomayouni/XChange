document.addEventListener("turbolinks:load", function() {
	$add_to_groups_input = $("[data-behaviour='autocomplete_add_to_groups']")
	
	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search_add_to_groups?add_to_groups_q=" + phrase;
		},
		categories: [
			{
				listLocation: "groups",
				header: "<strong>-- Users --</strong>",
			}
		],
		list: {
			onChooseEvent: function() {
				var url = $add_to_groups_input.getSelectedItemData().url
				url = url.split('/')
				url = '/add_to_group/' + url[2]
				Turbolinks.visit(url)
			}
		}
	}
	$add_to_groups_input.easyAutocomplete(options)
})