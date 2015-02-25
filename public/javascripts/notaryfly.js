// Additional language
 
$(function(){
	$('#notary_search_additional_language').select(function(){
		$("#languages").toggle();
	});
});

// Datepicker
$(function()
{
	
	$(".datepicker").datepicker({ minDate: 0,
		clearText: 'Erase' })
});

// GMap
$(function(){
	$('a.gmap').click(function(){
		$("#gmap").toggle();
		$("a.gmap").html("Show Map")
	});
});


// Fancyzoom
$(function() {
    try {
        $('a.fancyzoom').fancyZoom();
    }
    catch (e) {
        console.log(e);
    }
});


// Notary search appear
$(function(){
	$('#search_button').click(function(){
		$("#results").fadeIn();
	});
});

// Notary search ?????
$(function(){
	$('#notary_search_additional_language').change(function(){
		$("#languages").fadeIn();
	});
});

// Same as above checkboxes for addresses
$(function(){
	$('#js_same_as_above').click(function(){
            if(document.getElementById('js_same_as_above').checked)
                {
		n1 = $("#notary_weekday_deliver_address").val();
		n2 = $("#notary_weekday_deliver_city").val();
		n3 = $("#notary_weekday_deliver_state").val();
		n4 = $("#notary_weekday_deliver_zip_code").val();
		$("#notary_weekend_deliver_address").val(n1);
		$("#notary_weekend_deliver_city").val(n2);
		$("#notary_weekend_deliver_state").val(n3);
		$("#notary_weekend_deliver_zip_code").val(n4);
                }
                else
                    {
                $("#notary_weekend_deliver_address").val("");
		$("#notary_weekend_deliver_city").val("");
		$("#notary_weekend_deliver_state").val("");
		$("#notary_weekend_deliver_zip_code").val("");
                    }
	});
	
	$('#js_same_as_above_2').click(function(){

            if(document.getElementById('js_same_as_above_2').checked)
                {
		n1 = $("#notary_weekend_deliver_address").val();
		n2 = $("#notary_weekend_deliver_city").val();
		n3 = $("#notary_weekend_deliver_state").val();
		n4 = $("#notary_weekend_deliver_zip_code").val();
		
		$("#notary_billing_deliver_address").val(n1);
		$("#notary_billing_deliver_city").val(n2);
		$("#notary_billing_deliver_state").val(n3);
		$("#notary_billing_deliver_zip_code").val(n4);
                }
                else
                    {
                $("#notary_billing_deliver_address").val("");
		$("#notary_billing_deliver_city").val("");
		$("#notary_billing_deliver_state").val("");
		$("#notary_billing_deliver_zip_code").val("");
                    }
	});
});

// Display tracking fields on order page
$(function() { 
	$("#order_delivery_options").click(function() { 
	  var selected = $("#order_delivery_options option[@selected]");
		if (selected.text() == 'Overnight to Notary') {
			$(".fade_in").fadeIn();
		}
	
		else if (selected.text() == 'Overnight to Borrower') {
				$(".fade_in").fadeIn();
		
		}
		
		else {
			$(".fade_in").fadeOut();
		};
	}); 
});


// Phone number masking
jQuery(function($){
    try {
       $("#notary_day_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#notary_evening_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#notary_mobile_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#notary_work_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#notary_fax_number").mask("(999) 999-9999", {placeholder:" "});
       $("#client_home_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#client_direct_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#client_mobile_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#client_fax_number").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_1_work_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_1_home_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_1_mobile_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_2_home_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_2_work_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#order_borrower_2_mobile_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#agent_home_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#agent_direct_phone").mask("(999) 999-9999", {placeholder:" "});
       $("#agent_mobile_phone").mask("(999) 999-9999", {placeholder:" "});
    }
    catch (e) {
        console.log(e);
    }
});