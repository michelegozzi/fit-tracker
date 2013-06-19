jQuery(document).ready(function() {

	// copy timepart value to time value
	jQuery('input.activity-timepart-field').each(function () {
		
		var dest = jQuery(this).siblings('input.activity-time-field').first();

		if (dest === undefined)	{
			console.error('sibling element \"input.activity-time-field\" not found');
		}
		else {
			console.log('copy from ' + jQuery(this).attr('id') + ' to ' + dest.attr('id'));
			dest.val(jQuery(this).val());
		}
	});
	
	// set timepicker function for all time fields
	jQuery('.activity-time-field').timepicker();
});

function initTotalDuration(categoryKey) {
	var rows = jQuery("#" + categoryKey + "-activities tbody > tr");
	var duration = 0;

	//console.log(rows);
	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			console.log(td);
			duration += parseInt(td.html());
		}
	);

	jQuery("#" + categoryKey + "-total-duration").html(duration);
}

function remove_activity_fields(link) {
	jQuery(link).prev("input[type=hidden]").val('1');
	
	var tr = jQuery(link).parents('tr');
	var tbody = tr.parents('tbody');
	var categoryKey = tbody.attr('categoryKey');
	console.log(categoryKey);	

	tr.children('input[type=hidden]')

	console.log(tr);
	tr.hide();

	var duration = 0;
	var rows = jQuery(tbody).children("tr");

	console.log(rows);

	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			console.log(td);
			duration += parseInt(td.html());
		}
	);

	console.log(duration);
	jQuery("#" + categoryKey + "-total-duration").html(duration);
}

// add a new row containing activity fields
function add_activity_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	var table = jQuery(link).parents('table');
	var tbody = table.find('tbody');
	var categoryId = tbody.attr('categoryId');
	tbody.append(content.replace(regexp, new_id)).find('input.activity-time-field').timepicker();
}