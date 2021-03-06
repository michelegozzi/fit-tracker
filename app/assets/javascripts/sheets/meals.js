jQuery(document).ready(function() {
	// copy timepart value to time value
	jQuery('input.meal-timepart-field').each(function () {
		
		var dest = jQuery(this).siblings('input.meal-time-field').first();

		if (dest === undefined)	{
			console.error('sibling element \"input.meal-time-field\" not found');
		}
		else {
			//console.log('copy from ' + jQuery(this).attr('id') + ' to ' + dest.attr('id'));
			dest.val(jQuery(this).val());
		}
	});

	jQuery('.meal-time-field').each(function(){
		jQuery(this).customTimePicker(false);
	});
});

function initTotalCalories(categoryKey) {
	var rows = jQuery("#" + categoryKey + "-meals tbody > tr");
	var calories = 0;

	//console.log(rows);
	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			//console.log(td);
			calories += parseInt(td.html());
		}
	);

	jQuery("#" + categoryKey + "-total-calories").html(calories);
}

function remove_meal_fields(link) {
	jQuery(link).prev("input[type=hidden]").val('1');
	//$(link).up(".fields").hide();
	
	var tr = jQuery(link).parents('tr');
	var tbody = tr.parents('tbody');
	var categoryKey = tbody.attr('categoryKey');
	//console.log(categoryKey);	

	tr.children('input[type=hidden]')

	//console.log(tr);
	tr.hide();

	var calories = 0;
	var rows = jQuery(tbody).children("tr");

	//console.log(rows);

	rows.each(
		function () {
			var td = jQuery(this).find('td:eq(2)');
			//console.log(td);
			calories += parseInt(td.html());
		}
	);

	//console.log(calories);
	jQuery("#" + categoryKey + "-total-calories").html(calories);
}

// add a new row containing meal's fields
function add_meal_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	var table = jQuery(link).parents('table');
	var tbody = table.find('tbody');
	var categoryId = tbody.attr('categoryId');
	var ar = tbody.append(content.replace(regexp, new_id));
	
	ar.find('input.meal-time-field').last().customTimePicker(true);
	ar.find('input.meal-name-field').last().customTypeahead({
		//url: window.location.origin+'/helpers/foods',
    url: '/helpers/foods',
		property: 'name',
		targetProperty: 'calories',
		targetObj: ar.find('input.meal-calories-field').last()
	});
}