document.addEventListener("turbolinks:load", function() {
	$groups_input = $("[data-behaviour='autocomplete_groups']")
	
	var options = {
		getValue: "name",
		url: function(phrase){
			return "/search_groups?groups_q=" + phrase;
		},
		categories: [
			{
				listLocation: "groups",
				header: "<strong>-- Groups --</strong>",
			}
		],
		list: {
			onChooseEvent: function() {
				var url = $groups_input.getSelectedItemData().url
				Turbolinks.visit(url)
			}
		}
	}
	$groups_input.easyAutocomplete(options)
})