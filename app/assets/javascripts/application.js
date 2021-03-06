// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .
//= require Chart.bundle
//= require chartkick
//= require_tree ./channels
//= require jquery_ujs
//= require geocomplete
//= require moment
//= require daterangepicker

function show_password(){
	var x = document.getElementById("input_password");

	if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }

}

//PSA: If you want to do any jquery, do it in this block of code.
$(document).on('turbolinks:load', function() {

	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	});

	$(".settings_selector").mouseenter(function(){
	    // alert("You entered testing!");
	    $(".settings_selector").css({"background":"red"});
	});

	$(".settings_selector").mouseleave(function(){
	    // alert("You entered testing!");
	    $(".settings_selector").css({"background":"white"});
	});

	// collapsible side bar
	$(document).on('click tap touchstart', '.collapse-menu-button', function(){
		$('.side-menu').show();
	});

	$(document).on('click tap touchstart', '.side-menu-bg', function(){
		$(".side-menu").hide();
	});

	$(window).on('resize', function(){
		if (!$(".navbar-toggler").is(":visible")){
			$(".side-menu").hide();
		}
	});

	//Toggle buttons on dashboard page
	$( "#borrowingButton" ).click(function() {
        $('#borrowing').fadeIn();
        $('#lending').hide();
     });
    $( "#lendingButton" ).click(function() {
        $('#lending').fadeIn();
    	$('#borrowing').hide();
    });

	// live searches' search
	$( "#live-item-search-input" ).keyup(function() {
		var search_input = $( "#live-item-search-input" ).val().trim().toLowerCase();
		$(".live-search-container").each(function() {
			var item_title = $(this).find(".item-title").text().trim().toLowerCase();
			if (item_title.indexOf(search_input) >= 0 || search_input == "") {
				$(this).show();
			}
			else {
				$(this).hide();
			}
		});
	});

	// reponsive star ratings
	$(".star-rating").mouseenter(function() {
		star_value = $(this).attr("star-value");
		for (i = 0; i < star_value; i++) {
			$(".star-rating").eq(i).css("color", "#f2a900");
		}
	});
	$(".star-rating").click(function() {
		star_value = $(this).attr("star-value");
		$("#stars-rating").attr("clicked-value", star_value);
		$("#comment_rating").val(star_value);
		for (i = 0; i < star_value; i++) {
			$(".star-rating").eq(i).css("color", "#f2a900");
		}
		for (i = star_value; i < 5; i++) {
			$(".star-rating").eq(i).css("color", "rgb(161, 161, 161)");
		}
	});
	$(".star-rating").mouseleave(function() {
		star_value = $("#stars-rating").attr("clicked-value");
		for (i = star_value; i < 5; i++) {
			$(".star-rating").eq(i).css("color", "rgb(161, 161, 161)");
		}
	});
});
