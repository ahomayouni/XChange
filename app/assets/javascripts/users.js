$(document).ready(function() {
    $('#borrowing').hide(); 
    $('#lending').hide(); 
    $( "#borrowingButton" ).click(function() {
        $('#borrowing').show(); 
        $('#lending').hide(); 
    });
    $( "#lendingButton" ).click(function() {
        $('#lending').show(); 
        $('#borrowing').hide(); 
    });
}); 
