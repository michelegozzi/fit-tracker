function updateTips( t ) {
	jQuery( ".validateTips" )
	.text( t )
	.addClass( "ui-state-highlight" );
	setTimeout(function() {
		jQuery( ".validateTips" ).removeClass( "ui-state-highlight", 1500 );
	}, 500 );
}

function checkLength( o, n, min, max ) {
	if ( o.val().length > max || o.val().length < min ) {
		o.addClass( "ui-state-error" );
		updateTips( "Length of " + n + " must be between " +
			min + " and " + max + "." );
		return false;
	} else {
		return true;
	}
}

function checkRegexp( o, regexp, n ) {
	if ( !( regexp.test( o.val() ) ) ) {
		o.addClass( "ui-state-error" );
		updateTips( n );
		return false;
	} else {
		return true;
	}
}

function printTime(o) {
	var result = '';

	var date = new Date(o);
	
	var hh = date.getHours();
	var mm = date.getMinutes();
	if (hh > 12) {
		result += hh - 12;
	} else if (hh == 0 ) {
		result += "12";
	} else {
		result += hh;
	}
	result += ":" + mm;

	if (hh >= 12) {
	    result += " PM";
	} else {
	    result += " AM";
	}

	console.log('printTime = ' + result);

	return result;
}

function removeItem(o) {
	console.log(o);
	var tr = o.parents('tr');
	var tbody = tr.parents('tbody');
	var category = tbody.attr('category');
	console.log(category);	

	console.log(tr);
	tr.remove();

	var calories = 0;

	var rows = jQuery(tbody).children("tr");

	console.log(rows);

	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			console.log(td);
			calories += parseInt(td.html());
		}

	);

	console.log(calories);
	jQuery("#" + category + "-total-calories").html(calories);
}

jQuery(document).ready(function() {
	jQuery( "#dialog-form" ).dialog({
		autoOpen: false,
		height: 400,
		width: 350,
		modal: true,
		buttons: {
			"Add new meal": function() {
				console.log('Add new meal');
				var bValid = true;
				var category = jQuery("#mealCategory").val();
				var mealName = jQuery( "#mealName" );
				var mealTime = jQuery( "#mealTime" );
				var mealCalories = jQuery( "#mealCalories" );

				mealName.removeClass( "ui-state-error" );
				mealTime.removeClass( "ui-state-error" );
				mealCalories.removeClass( "ui-state-error" );

				bValid = bValid && checkLength( mealName, "name", 3, 16 );
				//bValid = bValid && checkLength( mealTime, "time", 5, 5 );
				bValid = bValid && checkLength( jQuery( "#mealCalories" ), "calories", 1, 4 );

				//bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+jQuery/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
				// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
				//bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\jQuery%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\jQuery%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?jQuery/i, "eg. ui@jquery.com" );
				//bValid = bValid && checkRegexp( password, /^([0-9a-zA-Z])+jQuery/, "Password field only allow : a-z 0-9" );

				if ( bValid ) {
					// create row
					jQuery( "#" + category + "-meals tbody" ).append(
					"<tr><td>" + mealName.val() + "</td>"
					+ "<td>" + mealTime.val() + "</td>"
					+ "<td>" + mealCalories.val() + "</td>"
					+ "<td><i class=\"icon-remove\"></i></td></tr>"
					);

					// create remove event & calculate calories
					var calories = 0;
					/*
					var rows = jQuery( "#" + category + "-meals tbody > tr");
					console.log(rows);
					rows.each(
						function () {
							jQuery(this).find('.icon-remove').click( function() {
								removeItem(jQuery(this));
							});

							var td = jQuery(this).find('td:eq(2)');
							console.log(td);
							calories += parseInt(td.html());
						}
					);
					*/

					// set remove action
					var lastRow = jQuery( "#" + category + "-meals tbody > tr" ).last();
					lastRow.find('.icon-remove').click( function() {
						removeItem(jQuery(this));
					});

					// update calories
					var td = lastRow.find('td:eq(2)');
					console.log(td);
					calories += parseInt(td.html());

					console.log("calories=" + calories);

					var totalCalories = jQuery("#" + category + "-total-calories");

					calories += parseInt(totalCalories.html());
					totalCalories.html(calories);

					jQuery( this ).dialog( "close" );
				}
			},
			Cancel: function() {
				jQuery( this ).dialog( "close" );
			}
		},
		close: function() {
			jQuery("#mealName").val("");
			jQuery("#mealName").removeClass("ui-state-error");
			jQuery("#mealTime").val("");
			jQuery("#mealTime").removeClass("ui-state-error");
			jQuery("#mealCalories").val("");
			jQuery("#mealCalories").removeClass("ui-state-error");
			
		},
		open: function() {
			jQuery("#mealName").val("");
			jQuery("#mealTime").val("");
			jQuery("#mealCalories").val("0");

			$('#mealTime').timepicker('setTime', printTime(jQuery.now()));
		}
	});

	jQuery('#add-breakfast-meal')
		.click(function() {
			jQuery('#dialog-form input#mealCategory').val('breakfast');
			jQuery('#dialog-form').dialog('open');
	});

	jQuery('#add-lunch-meal')
		.click(function() {
			jQuery('#dialog-form input#mealCategory').val('lunch');
			jQuery('#dialog-form').dialog('open');
	});

	jQuery('#add-dinner-meal')
		.click(function() {
			jQuery('#dialog-form #mealCategory').val('dinner');
			jQuery('#dialog-form').dialog('open');
	});

	//jQuery('#mealTime').timepicker();

	// copy timepart value to time value
	jQuery('input.meal-timepart-field').each(function () {
		
		var dest = jQuery(this).siblings('input.meal-time-field').first();

		if (dest === undefined)	{
			console.error('sibling element \"input.meal-time-field\" not found');
		}
		else {
			console.log('copy from ' + jQuery(this).attr('id') + ' to ' + dest.attr('id'));
			dest.val(jQuery(this).val());
		}
	});
	
	jQuery('.meal-time-field').timepicker();

	

	//
	//jQuery( '#mealTime' ).datetimepicker({
	//});
});

function initTotalCalories(category) {
	var rows = jQuery("#" + category + "-meals tbody > tr");
	var calories = 0;

	console.log(rows);
	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			console.log(td);
			calories += parseInt(td.html());
		}
	);

	jQuery("#" + category + "-total-calories").html(calories);
}




function remove_fields(link) {
	$(link).prev("input[type=hidden]").val("1");
	$(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	$(link).parent().before(content.replace(regexp, new_id));
}