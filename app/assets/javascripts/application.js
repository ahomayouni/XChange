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
//= require cable

function show_password(){
	var x = document.getElementById("input_password");

	if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }

}

// Jquery side of things
$(document).ready(function() {
	$(".settings_selector").mouseenter(function(){
	    // alert("You entered testing!");
	    $(".settings_selector").css({"background":"red"});
	});
	$(".settings_selector").mouseleave(function(){
	    // alert("You entered testing!");
	    $(".settings_selector").css({"background":"white"});
	});
})

