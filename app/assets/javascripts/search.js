document.addEventListener("turbolinks:load", function() {
	$input = $("[data-behaviour='autocomplete']")
	
	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search?q=" + phrase;
		},
		categories: [
			{
				listLocation: "listings",
				header: "<strong>-- Listings --</strong>",
			},
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