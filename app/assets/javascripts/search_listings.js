document.addEventListener("turbolinks:load", function() {
	$listings_input = $("[data-behaviour='autocomplete_listings']")
	
	var options = {
		getValue: "title",
		url: function(phrase){
			return "/search_listings?q=" + phrase;
		},
		categories: [
			{
				listLocation: "listings",
				header: "<strong>-- Listings --</strong>",
			}
		],
		list: {
			onChooseEvent: function() {
				var url = $listings_input.getSelectedItemData().url
				Turbolinks.visit(url)
			}
		}
	}
	$listings_input.easyAutocomplete(options)
})