document.addEventListener("turbolinks:load", function() {
	$input = $("[data-behaviour='autocomplete_users']")
	
	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search_users?users_q=" + phrase;
		},
		categories: [
			{
				listLocation: "users",
				header: "<strong>-- Users --</strong>",
			}
		],
		list: {
			onChooseEvent: function() {
				var url = $input.getSelectedItemData().url
				Turbolinks.visit(url)

			}
		}
	}
	$input.easyAutocomplete(options)
})