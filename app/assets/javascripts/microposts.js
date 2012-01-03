//TODO: Didn't work putting this into the coffeescript file (micropost.js.coffee). Find a better place for this
$("#micropost_content").live('keyup', function() {
	var maxChar = 140;
	var count = $(this).val().length;
	var remainingChar = maxChar - count;
	$("#counter").html(remainingChar);
	if(remainingChar > 0) {
		$("#counter").css('color', 'green');
	} else {
		$("#counter").css('color', 'red');
	}
});