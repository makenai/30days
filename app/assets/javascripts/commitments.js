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

	$('#new_check_in').submit(function(e) {
		e.preventDefault();
		var data = $(this).serialize();
		$.post( $(this).attr('action'), data, function( html ) {
			$('#days div.active').replaceWith( html );
			$('#days div.row:first').click();
		}).error( function( response ) {
			alert( response.responseText );
			$('#check_in_note').focus();
		});
	});

	$('#days').on('click', 'div.row', function(e) {
		var $row = $(this),
			data = $row.data(),
			note = $row.find('span.note')[0],
			position = $(this).prevAll().length,
			commitment_id = $('#days').data('commitment-id');
		e.preventDefault();
		$('#days div.active').removeClass('active');
		$row.addClass('active');
		$('#check-in-form').animate( { top: ( position * 34 ) + 'px' }, 200 );
		$('#check_in_checkin_date').val( data.date );
		$('#check_in_note').attr( 'placeholder', 'What did you do to progess on day ' + data.number + '?' );
		var note_id = $(note).data('id');
		if ( note_id ) {
			$('#check_in_note').val( $(note).text() );
			$('#check-in-button').val('Update');
		} else {
			$('#check_in_note').val('');
			$('#check-in-button').val('Check In');
		}
		$('#check_in_note').focus();
	});

	$('#check_in_note').focus();

});