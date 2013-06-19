jQuery(document).ready(function () {
	jQuery('#mealsAccordion').accordion( { collapsible: true, heightStyle: "content" });
	jQuery('#activitiesAccordion').accordion( { collapsible: true, heightStyle: "content" });

	jQuery('input:radio[class=waterGlasses][value='+jQuery('input#waterGlassesCheckedValue').val()+']').prop('checked', true);
	jQuery('input:radio[class=energyLevel][value='+jQuery('input#energyLevelCheckedValue').val()+']').prop('checked', true);
	jQuery('input.waterGlasses').rating( { stylePrefix: 'glass' } );
	jQuery('input.energyLevel').rating( { stylePrefix: 'battery' } );
	//$.fn.rating.options.starWidth = '50';

	$('.auto-submit-star').rating({
		callback: function(value, link){
			alert(value);
		}
	});
});