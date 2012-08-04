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

	$('#days').on('click', 'a.day', function(e) {
		e.preventDefault();
		$('#days div.active').removeClass('active');
		$(this).closest('div').addClass('active');
		var data = $(this).data();
		$('#check-in-form').animate( { top: ((data.position * 34) - 1 )+ 'px' }, 200 );
		$('#check_in_checkin_date').val( data.date );
		$('#check_in_note').attr( 'placeholder', 'What did you do to progess on day ' + data.number + '?' );
	});

});