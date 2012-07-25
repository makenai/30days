$(function() {

	// Open / Close goal tab
	$('#open-tab').click(function(e) {
		e.preventDefault();
		$(this).slideUp();
		$('#new-goal').animate({ 'margin-top': '50px' }, 'slow', 'easeOutBounce', function() {
			$('#close-tab').slideDown().css( 'display', 'block' );
		});
	});

	$('#close-tab').click(function(e) {
		e.preventDefault();
		$(this).slideUp();
		$('#new-goal').animate({ 'margin-top': '-16px' }, 'slow', 'easeOutBounce', function() {
			$('#open-tab').slideDown().css( 'display', 'block' );
		});
	});

	$('#calendar').on('click', '#next-month, #prev-month', function(e) {
		e.preventDefault();
		$('#calendar').load( this.getAttribute('href') );
	});

});