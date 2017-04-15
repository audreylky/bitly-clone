$(document).ready(function(){
	// alert('hi'); // to check if ajax is working!!

	$('form').submit(function(event) {
		// use this to intercept the connection with the form and take over as middle man
		event.preventDefault();
			$.ajax({
			// ajax intercepted, take the info from the form.
			// it does everything in the background.
				url: '/urls',
				method: 'post',
				data: $(this).serialize(),
				dataType: 'json', //very important. We are expecting json file from the form.

			//callbacks => beforeSend, success, error, afterSend, complete
				beforeSend: function() {
        	$('form input').val('Loading...');
      	},

      	complete: function() {
        	$('form input').val('DONE!');
      	},

      	success: function(data) {
        	$('tr:first-child').after('<tr> <td>' + data.long_url + '</td> <td>' + data.short_url + '</td> <td>' + data.counter + '</td> </tr>')
      	},


	// 		success: function(data) {
	// 			alert('yay!')
	// 			// ajax doesn't know success or error. it only knows if the file it receiving is JSON
	// 		},
				error: function(data) {
	// 			// if you get json back but want to show error, put status 400 in static.rb
	// 			alert('boooo!')
				}
		});
	});
});