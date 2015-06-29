
function formValidations()
{
	onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('client_company_name').value)== 0) {
       error += "<li>Company Name is mandatory</li>"
       document.getElementById('client_company_name').focus();
	   onsubmit1 = false;
    }
	 if ( trim(document.getElementById('client_client_name').value)== 0) {
       error += "<li>Client Name is mandatory</li>"
	   onsubmit1 = false;
    }
     if ( trim(document.getElementById('client_title').value)==0) {
       error += "<li>Title is mandatory</li>"
	   onsubmit1 = false;
    }
	 if ( trim(document.getElementById('client_address').value)== 0) {
       error += "<li>Address is mandatory</li>"
	   onsubmit = false;
    }
	 if ( trim(document.getElementById('client_city').value)==0 ) {
       error += "<li>City is mandatory</li>"
	   onsubmit1 = false;
    }
    if ( trim(document.getElementById('client[state]').value)==0 ) {
       error += "<li>State is mandatory</li>"
	   onsubmit1 = false;
    }
	 if ( trim(document.getElementById('client_zip_code').value)==0 ) {
       error += "<li>Zip Code is mandatory</li>"
	   onsubmit1 = false;
    }
    if ( trim(document.getElementById('client_home_phone').value)==0 ) {
       error += "<li>Telephone is mandatory</li>"
	   onsubmit1 = false;
    }
    if ( trim(document.getElementById('user_email').value)== 0) {
       error += "<li>Email is mandatory</li>"
	   onsubmit1 = false;
    }
	else if ( isValidEmail(document.getElementById('user_email').value)==false) {
       error += "<li>Enter Valid Email</li>"
	   onsubmit1 = false;
    }
    if ( trim(document.getElementById('user_password').value)==0 ) {
       error += "<li>Password is mandatory</li>"
	   onsubmit1 = false;
    }
	else if ( document.getElementById('user_password').value!=document.getElementById('user_password_confirmation').value) {
       error += "<li>Password is Mismatch</li>"
	   onsubmit1 = false;
    }
    else if(trim(document.getElementById('user_password').value)<6)
        {
        error += "<li>Password is too short (minimum is 6 characters)</li>"
	   onsubmit1 = false;
        }

    error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
    document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;

}


function notary_profile_validations()
{
    onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('notary_first_name').value)== 0) {
       error += "<li>First Name is mandatory</li>"
       document.getElementById('notary_first_name').focus();
	   onsubmit1 = false;
    }

    if (trim( document.getElementById('notary_last_name').value)== 0) {
       error += "<li>Last Name is mandatory</li>"
       	   onsubmit1 = false;
    }

    if (trim( document.getElementById('notary_day_phone').value)== 0) {
       error += "<li>Preferred Phone is mandatory</li>"
      	   onsubmit1 = false;
    }

    if (trim( document.getElementById('notary_mobile_phone').value)== 0) {
       error += "<li>Mobile Phone is mandatory</li>"
      	   onsubmit1 = false;
    }

    if (trim( document.getElementById('user_email').value)== 0) {
       error += "<li>Email is mandatory</li>"
      	   onsubmit1 = false;
    }
        else if ( isValidEmail(document.getElementById('user_email').value)==false) {
       error += "<li>Enter Valid Email</li>"
	   onsubmit1 = false;
    }

    if (trim( document.getElementById('user_password').value)== 0) {
       error += "<li>Password is mandatory</li>"
      	   onsubmit1 = false;
    }
    else if (trim( document.getElementById('user_password').value)!= trim( document.getElementById('user_password_confirmation').value)) {
       error += "<li>Password is Mismatch</li>"
      	   onsubmit1 = false;
    }
    else if(trim(document.getElementById('user_password').value)<6)
      {
       error += "<li>Password is too short (minimum is 6 characters)</li>"
       onsubmit1 = false;
        }

    //if (trim( document.getElementById('notary_notary_commision_number').value)== 0) {
       //error += "<li>Notary Commission is mandatory</li>"
      	//   onsubmit1 = false;
   // }
    //    if (trim( document.getElementById('notary_notary_commision_number_expiration_date').value)== 0) {
     //  error += "<li>Expiration Date is mandatory</li>"
    //  	   onsubmit1 = false;
   // }

    //if (document.getElementById('notary_e_and_o_insurance').value== "Yes") {
    //  if (trim( document.getElementById('notary_e_and_o_insurance_expiration_date').value)== 0) {
    //   error += "<li>E&O Insurance Expiration Date is mandatory</li>"
     // 	   onsubmit1 = false;
    //}

   // }
   // error += "</ul>";
	//document.getElementById('signupvalid').innerHTML = error;
      //  document.getElementById('success').style.display = "none";
    //document.getElementById('signupvalid').style.display = "";

	//if(onsubmit1)
	//{
	//	document.getElementById('signupvalid').style.display = "none";
	//}
	//return onsubmit1;
}






function client_order_new()
{
     timechk = false;
    onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('order_loan_number').value)== 0) {
        error += "<li>Loan/Escrow is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_date').value)== 0) {
       error += "<li>Signing Date is mandatory</li>"
        onsubmit1 = false;
    }
    else
        timechk =   true;
    if (trim( document.getElementById('order_signing_time').value)== 0) {
       error += "<li>Signing Time is mandatory</li>"
        onsubmit1 = false;
    }
  
    if(timechk)
        {
            
           if(!timeCheck(document.getElementById('order_signing_time').value,document.getElementById('order_signing_date').value))
             {
             error += "<li>This is not a valid Signing Date or Signing Time </li>"
              onsubmit1 = false;
             }
        }
    if (trim( document.getElementById('order_loan_type').value)== 0) {
       error += "<li>Transaction Type is mandatory</li>"
        onsubmit1 = false;
    }
//    if (trim( document.getElementById('order_sets_of_docs').value)== 0) {
//       error += "<li>Sets of Documents is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_delivery_options').value)== 0) {
//       error += "<li>Delivery Options is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_required_language').value)== 0) {
//       error += "<li>Required Language is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_attorney_required').value)== 0) {
//       error += "<li>Attorney Required is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_title_producer_required').value)== 0) {
//       error += "<li>Title Producer Required is mandatory</li>"
//        onsubmit1 = false;
//    }
    if (trim( document.getElementById('order_borrower_1_first_name').value)== 0) {
       error += "<li>Signer #1 First Name is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_borrower_1_last_name').value)== 0) {
       error += "<li>Signer #1 Last Name is mandatory</li>"
        onsubmit1 = false;
    }
    //if (trim( document.getElementById('order_borrower_1_home_phone').value)== 0) {
    //   error += "<li>Home Phone is mandatory</li>"
     //   onsubmit1 = false;
  //  }
      if (trim( document.getElementById('order_borrower_1_mobile_phone').value)== 0) {
       error += "<li>Cell Phone is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_address').value)== 0) {
       error += "<li>Address is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_city').value)== 0) {
       error += "<li>City is mandatory</li>"
        onsubmit1 = false;
    }if (trim( document.getElementById('order_signing_location_state').value)== 0) {
       error += "<li>State is mandatory</li>"
        onsubmit1 = false;
    }if (trim( document.getElementById('order_signing_location_zip_code').value)== 0) {
       error += "<li>Zip Code is mandatory</li>"
        onsubmit1 = false;
    }

    error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
        document.getElementById('signupvalid').style.display = "";
    
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;
}


function client_order_edit()
{
    timechk = false;
    onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('order_loan_number').value)== 0) {
       error += "<li>Loan/Escrow is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_date').value)== 0) {
       error += "<li>Signing Date is mandatory</li>"
        onsubmit1 = false;
    }
    else
       timechk =   true;
    if (trim( document.getElementById('order_signing_time').value)== 0) {
       error += "<li>Signing Time is mandatory</li>"
        onsubmit1 = false;
    }
    
        if(timechk)
        {
           
           if(!timeCheck(document.getElementById('order_signing_time').value,document.getElementById('order_signing_date').value))
             {
             error += "<li>This is not a valid Signing Date or Signing Time </li>"
              onsubmit1 = false;
              }
              
        }

    if (trim( document.getElementById('order_loan_type').value)== 0) {
       error += "<li>Transaction Type is mandatory</li>"
        onsubmit1 = false;
    }
//    if (trim( document.getElementById('order_sets_of_docs').value)== 0) {
//       error += "<li>Sets of Documents is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_delivery_options').value)== 0) {
//       error += "<li>Delivery Options is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_required_language').value)== 0) {
//       error += "<li>Required Language is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_attorney_required').value)== 0) {
//       error += "<li>Attorney Required is mandatory</li>"
//        onsubmit1 = false;
//    }
//    if (trim( document.getElementById('order_title_producer_required').value)== 0) {
//       error += "<li>Title Producer Required is mandatory</li>"
//        onsubmit1 = false;
//    }
    if (trim( document.getElementById('order_borrower_1_first_name').value)== 0) {
       error += "<li>Signer #1 First Name is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_borrower_1_last_name').value)== 0) {
       error += "<li>Signer #1 Last Name is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_borrower_1_home_phone').value)== 0) {
       error += "<li>Home Phone is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_address').value)== 0) {
       error += "<li>Address is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_city').value)== 0) {
       error += "<li>City is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_state').value)== 0) {
       error += "<li>State is mandatory</li>"
        onsubmit1 = false;
    }
    if (trim( document.getElementById('order_signing_location_zip_code').value)== 0) {
       error += "<li>Zip Code is mandatory</li>"
        onsubmit1 = false;
    }

    error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
        document.getElementById('signupvalid').style.display = "";

	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
       	return onsubmit1;
}



function client_order_fill_notary_confirmation()
{
     var returnVal = false;
    if(client_order_new())
        {
    var answer= confirm("Your Order will be Saved and your account will be invoiced. Are you sure you want to ACTIVATE this Order?");
    if(answer)

    returnVal = true;

    else
        returnVal = false;
        }
        else
            returnVal = false;
    return returnVal;
}


function client_order_fill_notary_later_confirmation()
{
     var returnVal = false;
    if(client_order_new())
        {
    var answer= confirm("Are you sure you want to save this order? Your account will be charged a credit.");
    if(answer)

    returnVal = true;

    else
        returnVal = false;
        }
        else
            returnVal = false;
    return returnVal;
}


function e_O_Insurance_display()
{
    var selVal = document.getElementById("notary_e_and_o_insurance").value;
    
    if(selVal=="Yes")
        {
            document.getElementById("e_and_o_amt_date_label").style.display="";
            document.getElementById("e_and_o_amt_date_field").style.display="";
        }
     else
         {
             document.getElementById("e_and_o_insurance_amount").value="";
             document.getElementById("notary_e_and_o_insurance_expiration_date").value="";
             document.getElementById("e_and_o_amt_date_label").style.display="none";
            document.getElementById("e_and_o_amt_date_field").style.display="none";
         }
}


function client_brker_allow_status()
{
    var selVal = document.getElementById("agent_notify_agent").value;
    
    if(selVal=="Yes")
        {
           // document.getElementById("client_broker_new_cmpny_brker_field").style.display="";
            document.getElementById("client_broker_new_cmpny_brker_label").style.display="";
            document.getElementById("client_broker_new_email_label").style.display="";
           // document.getElementById("client_broker_new_email_field").style.display="";
        }
    else
        {
             document.getElementById("agent_company_name").value="";
             document.getElementById("agent_broker_name").value="";
             document.getElementById("agent_email").value="";
             document.getElementById('signupvalid').style.display = "none";
             //document.getElementById("client_broker_new_cmpny_brker_field").style.display="none";
             document.getElementById("client_broker_new_cmpny_brker_label").style.display="none";
             document.getElementById("client_broker_new_email_label").style.display="none";
            // document.getElementById("client_broker_new_email_field").style.display="none";
        }
}

function client_brker_new_validation()
{
    onsubmit1 = true;
    var selVal = document.getElementById("agent_notify_agent").value;
    
            
	var error = "<ul>"
            if (trim( document.getElementById('agent_company_name').value)== 0) {
               error += "<li>Company Name is mandatory</li>"
               document.getElementById('agent_company_name').focus();
               onsubmit1 = false;
            }
	 if ( trim(document.getElementById('agent_broker_name').value)== 0) {
                error += "<li>Agent Name is mandatory</li>"
                onsubmit1 = false;
            }
        if ( trim(document.getElementById('agent_email').value)== 0) {
               error += "<li>Email Address is mandatory</li>"
               onsubmit1 = false;
            }
	else if ( isValidEmail(document.getElementById('agent_email').value)==false) {
                error += "<li>Enter Valid Email Address</li>"
                 onsubmit1 = false;
            }
            error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
        document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	
        

        return onsubmit1;
}
  
function notary_profile_address_validation()
{
    	onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('notary_weekday_deliver_address').value)== 0) {
               error += "<li>Week Day Delivery Address is mandatory</li>"
               document.getElementById('notary_weekday_deliver_address').focus();
               onsubmit1 = false;
    }
	 if ( trim(document.getElementById('notary_weekday_deliver_city').value)== 0) {
            error += "<li>Week Day Delivery City is mandatory</li>"
            onsubmit1 = false;
    }
     if ( trim(document.getElementById('notary_weekday_deliver_state').value)== 0) {
            error += "<li>Week Day Delivery State is mandatory</li>"
            onsubmit1 = false;
    }
     if ( trim(document.getElementById('notary_weekday_deliver_zip_code').value)== 0) {
            error += "<li>Week Day Delivery Zip Code is mandatory</li>"
            onsubmit1 = false;
    }
     if ( trim(document.getElementById('notary_weekend_deliver_address').value)== 0) {
            error += "<li>Week End Delivery Address is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_weekend_deliver_city').value)== 0) {
            error += "<li>Week End Delivery City is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_weekend_deliver_state').value)== 0) {
            error += "<li>Week End Delivery State is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_weekend_deliver_zip_code').value)== 0) {
            error += "<li>Week End Delivery Zip Code is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_billing_payable_to').value)== 0) {
            error += "<li>Payment Check Payable To is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_billing_deliver_address').value)== 0) {
            error += "<li>Payment Address is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_billing_deliver_city').value)== 0) {
            error += "<li>Payment City is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_billing_deliver_state').value)== 0) {
            error += "<li>Payment City is mandatory</li>"
            onsubmit1 = false;
    }
    if ( trim(document.getElementById('notary_billing_deliver_zip_code').value)== 0) {
            error += "<li>Payment Zip Code is mandatory</li>"
            onsubmit1 = false;
    }
        error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
        document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;
}


function notary_profile_exp_equip_valid()
{
    var selVal = document.getElementById("notary_email_document_capability").value;
    if(selVal=="Yes")
        {
            document.getElementById("notary_profile_exp_equip_label").style.display = "";
           // document.getElementById("notary_profile_exp_equip_field").style.display = "";
        }
     else
         {
            document.getElementById("notary_laser_printer").value = "No";
            document.getElementById("notary_printer_paper_type").value = "Letter";
            document.getElementById("notary_profile_exp_equip_label").style.display = "none";
          //  document.getElementById("notary_profile_exp_equip_field").style.display = "none";
        }
}

function notarized_documents_count_valid_yes()
{
    
     var selVal_yes = document.getElementById("notary_notarize_loan_documents_yes").value;

    if(selVal_yes)
        {
           
          document.getElementById("notary_notarized_documents_count").style.display = "block";
            document.getElementById("notarized_documents_count_label").style.display = "block";
         }
   
}

function notarized_documents_count_valid_no()
{

      var selVal_no = document.getElementById("notary_notarize_loan_documents_no").value;

    if(selVal_no)
        {
           document.getElementById("notary_notarized_documents_count").value = "under 50";
            document.getElementById("notary_notarized_documents_count").style.display = "none";
            document.getElementById("notarized_documents_count_label").style.display = "none";
         }
     
}




function notarized_bilingual_valid_yes()
{
     var selVal_yes = document.getElementById("notary_bilingual_yes").value;
    if(selVal_yes)
        {
           //document.getElementById("notary_bilingual_language").value = "English";
           document.getElementById("notary_bilingual_language").style.display = "block";
            document.getElementById("notarized_bilingual_label").style.display = "block";

          //  document.getElementById("notarized_bilingual_field").style.display = "";
         }
}

function notarized_bilingual_valid_no()
{
     var selVal_no = document.getElementById("notary_bilingual_no").value;
    if(selVal_no)
        {
           document.getElementById("notary_bilingual_language").value = "none";
           document.getElementById("notary_billingual_language_1").value = "none";
            document.getElementById("notary_bilingual_language").style.display = "none";
            document.getElementById("notarized_bilingual_label").style.display = "none";

          //  document.getElementById("notarized_bilingual_field").style.display = "";
         }
    }

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"").length;
}

function isValidEmail(email){
    var RegExp = /^((([A-Za-z0-9 ]|!|#|$|%|&|'|\*|\+|\-|\/|=|\?|\^|_|`|\{|\||\}|~)+(\.([A-Za-z0-9 ]|!|#|$|%|&|'|\*|\+|\-|\/|=|\?|\^|_|`|\{|\||\}|~)+)*)@((((([A-Za-z0-9 ])([A-Za-z0-9 ]|\-){0,61}([A-Za-z0-9])\.))*([A-Za-z0-9 ])([A-Za-z0-9 ]|\-){0,61}([A-Za-z0-9 ])\.)[\w]{2,4}|(((([0-9]){1,3}\.){3}([0-9]){1,3}))|(\[((([0-9]){1,3}\.){3}([0-9]){1,3})\])))$/
    if(RegExp.test(email)){
        return true;
    }else{
        return false;
    }
 }

 function validateNum(id) {
      	 var maintainplus = '';
	phone =  document.getElementById(id)       
        var numval = phone.value
        curphonevar = numval.replace(/[\\A-Za-z!"�$%^&*+_={};:'@#~,.�\/<>?|`�\]\[]/g,'');
 	phone.value = maintainplus + curphonevar;
 	var maintainplus = '';
 	phone.focus;
}

function order_delivery_options_display()
{
var opt = document.getElementById('order_delivery_options').value
if(opt=="Overnight to Borrower" || opt=="Overnight to Notary")
    {
        document.getElementById('shipped_via').style.display="";
        document.getElementById('tracking_no').style.display = "";
    }
    else
        {
        document.getElementById('shipped_via').style.display="none";
        document.getElementById('tracking_no').style.display = "none";
        }
}


function displayAddress(title,id) {
//alert(title);
//alert(label);
//alert(field);
		document.getElementById("weekdayAddressTitle"+id).style.display = "none"
		document.getElementById("weekendAddressTitle"+id).style.display = "none"
		document.getElementById("paymentAddressTitle"+id).style.display = "none"
                document.getElementById(title).style.display = ""
                
	}

function cancelWindow()
{
document.getElementById('divbox').style.display="none";
}

function textCounter(maxlimit) {
field = document.getElementById('notes_notes');

cntfield = document.getElementById('hcharLen');

if (field.value.length > maxlimit) { // if too long...trim it!
field.value = field.value.substring(0, maxlimit);
//document.getElementById('remLen1').innerHTML = field.value.substring(0, maxlimit);
}
// otherwise, update 'characters left' counter
else{
cntfield.value = maxlimit - field.value.length;
len = maxlimit - field.value.length;
document.getElementById('charLen').innerHTML = len+" characters left";
}
}

function displyNotes(showId,orderId)
{ 
    var Ids = document.getElementById("notes_view_"+orderId).value;
    var splitId = Ids.split(",");

    for(var i=0;i<splitId.length;i++)
    {
        if(splitId[i]!="")
        {
                if(showId==splitId[i])
                document.getElementById("note_content_"+splitId[i]).style.display = "";
                else
                hide(splitId[i]);
        }
    }
}

function hide(hideId)
{
document.getElementById("note_content_"+hideId).style.display = "none";
}

function find_note_add_lang()
{
    var val = document.getElementById("notary_search_additional_language").checked;
    if(val)
        {
            document.getElementById("languages").style.display = "";
        }
        else
            {
                document.getElementById("languages").style.display = "none";
            }
}

function client_order_new_shp_cour()
{
    var val = document.getElementById('order_return_shipping_courier').value;
    if(val!="Select one")
        {
                document.getElementById('order_return_account_number').disabled = false;
		//document.getElementById('order_return_account_number').value =document.getElementById('client_shipping_account_number').value;
            
        }
        else
            {
               document.getElementById('order_return_account_number').value ="";
                document.getElementById('order_return_account_number').disabled = true;
            }
}

function client_profile_shipping_cour()
{
    var val = document.getElementById('client_shipping_courier').value;
    if(val!="Select one")
        {
            
            document.getElementById('client_shipping_account_number').disabled = false;
        }
        else
            {
                document.getElementById('client_shipping_account_number').value = "";
                document.getElementById('client_shipping_account_number').disabled = true;
            }
}


function hide_dropdown()
{
    if(document.getElementById('filter')!=null)
    document.getElementById('filter').style.display="none";
}


function timeCheck(signingtime,signingdate)
{
var signTime = signingtime;
var time = "";
if(signingtime=="OPEN" || signingtime=="ASAP")
    signTime    = "11:59PM"
onsub = true;
findTime = signTime.search("AM");
if(findTime==-1)
{
timeSpt = signTime.split("PM");
time = " "+timeSpt[0]+" PM";
}
else
{
timeSpt = signTime.split("AM");
time = " "+timeSpt[0]+" AM";
}
 var Date1 = new Date();
 var Date2 = new Date(signingdate+time);

 if (Date1 > Date2)
 {
    onsub = false;
 }
else
    onsub = true;
return onsub;
}

function notary_terms()
{
    
    onsubmit1 = true;
    var error = "<ul>"
    
    if (document.getElementById('agree').checked==false) {
       error += "<li>Please accept the Terms of the Work Agreement</li>"
       	   onsubmit1 = false;
    }
    
    error += "</ul>";
    document.getElementById('signupvalid').innerHTML = error;
    document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}

    return onsubmit1;
}



function terms(notaryfee,agree1,agree2,agree3,agree4,valid)
{

    onsubmit1 = true;
    var error = "<ul>"
 
    if (document.getElementById(agree1).checked==false || document.getElementById(agree2).checked==false) {
       error += "<li>Please Accept the Terms and Conditions below.</li>"
       	   onsubmit1 = false;
    }
if (document.getElementById(agree4).checked==true){

	if ( trim(document.getElementById('notary_fee'+valid).value)== 0) {
            error += "<li>Please enter other fee amount</li>"
            onsubmit1 = false;
	}
	if ( trim(document.getElementById('order_other_fee_reason').value)== 0) {
            error += "<li>Please enter reason.</li>"
            onsubmit1 = false;
	}
}
if (document.getElementById(agree4).checked==false){

  if ( trim(document.getElementById('notary_fee'+valid).value)!=0) {
            error += "<li>You might entered the fee wrongly please remove it.Else check the other fee box to add your fee.</li>"
            onsubmit1 = false;
  }
  if ( trim(document.getElementById('order_other_fee_reason').value)!=0) {
            error += "<li>You might entered the reason wrongly please remove it.Else check the other fee box to add your fee.</li>"
            onsubmit1 = false;
  }
}

    error += "</ul>";
    document.getElementById('signupvalid'+valid).innerHTML = error;
    document.getElementById('signupvalid'+valid).style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid'+valid).style.display = "none";
	}
	

    return onsubmit1;
}

function buyCredits()
{
    
    document.getElementById("success").style.display = "none";
    document.getElementById("form_error").style.display = "none";
    
    onsubmit1 = true;
	var error = "<ul>"
    if (trim( document.getElementById('client_credit_card_number').value)== 0) {
       error += "<li>Enter credit card number</li>"
       	   onsubmit1 = false;
    }
     if (trim( document.getElementById('client_card_veification_number').value)== 0) {
       error += "<li>Enter credit card veification number</li>"
       	   onsubmit1 = false;
    }
    if (trim( document.getElementById('client_card_holder_name').value)== 0) {
       error += "<li>Enter credit card holder name</li>"
       	   onsubmit1 = false;
    }
    if (trim( document.getElementById('client_billing_address').value)== 0) {
       error += "<li>Enter billing address</li>"
       	   onsubmit1 = false;
    }
    if (trim( document.getElementById('client_city').value)== 0) {
       error += "<li>Enter city name</li>"
       	   onsubmit1 = false;
    }
    if (trim( document.getElementById('client_state').value)== 0) {
       error += "<li>Please select your state</li>"
       	   onsubmit1 = false;
    }
    if (trim( document.getElementById('client_zip_code').value)== 0) {
       error += "<li>Enter zip code</li>"
       	   onsubmit1 = false;
    }
    if ( document.getElementById('client_promo_code').value.length!= 0 && document.getElementById('client_promo_code').value!=document.getElementById('promocode').value) {
       error += "<li>Not a valid promo code</li>"
       	   onsubmit1 = false;
    }
    if(document.getElementById('client_credit_1').checked==false && document.getElementById('client_credit_5').checked == false && document.getElementById('client_credit_10').checked==false)
        {
            error += "<li>Please select anyone credits</li>"
       	   onsubmit1 = false;
        }

        error += "</ul>";
	document.getElementById('signupvalid').innerHTML = error;
    document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;

    return onsubmit1;
}

function setCursorFocus(fieldname)
{
    if(document.getElementById(fieldname)!=null)
    document.getElementById(fieldname).focus();
}


function loginFormValidations()
{
    document.getElementById('aflogin').style.display = "none";
	document.getElementById('err').style.display='none';
onsubmit1 = true;
var email = document.getElementById('login_email').value
var pass = document.getElementById('login_password').value
if((email=="" || email.length==0) && (pass=="" || pass.length==0))
{
document.getElementById('emailandpass').style.display = ""
document.getElementById('email').style.display = "none"
document.getElementById('pass').style.display = "none"
document.getElementById('invalidemail').style.display = "none"
onsubmit1 = false;
}
if(onsubmit1)
{
if(email=="" || email.length==0)
{
document.getElementById('email').style.display = ""
document.getElementById('emailandpass').style.display = "none"
document.getElementById('pass').style.display = "none"
document.getElementById('invalidemail').style.display = "none"
onsubmit1 = false;
}
}
if(onsubmit1)
{
if(pass=="" || pass.length==0)
{
document.getElementById('pass').style.display = ""
document.getElementById('emailandpass').style.display = "none"
document.getElementById('email').style.display = "none"
document.getElementById('invalidemail').style.display = "none"
onsubmit1 = false;
}
}

return onsubmit1;
}



function checkAll()
{
   var message = "";
   for (var i=0;i<document.test.elements.length;i++)
    {
        var e=document.test.elements[i];
            if (e.id=='user')
            {
                //e.checked=document.forms[1].CheckAll.checked;
                //document.forms[1].CheckAll.checked = true;
                e.checked = true;
            }
    }
}

function unCheckAll()
{
   for (var i=0;i<document.test.elements.length;i++)
    {
        var e=document.test.elements[i];
            if (e.id=='user')
            {
                e.checked = false;
            }
    }
}

function sendMsg() {
   
	var sComment = "";
	for (var i=0;i<document.test.elements.length;i++)
	{
		var e=document.test.elements[i];
		if (e.id=='user' && e.checked == true )
		{
			sComment += e.value+","
		}
	}
alert(sComment);
        document.getElementById('clientIds').value = sComment;
	
}


function checkPromocode()
{
    onsubmit1 = true;
    var error = ""

    if (trim( document.getElementById('promo_promo').value)== 0) {
       error += "Please Enter Promo Code."
       	   onsubmit1 = false;
    }
     if (trim( document.getElementById('credits_credits').value)== 0) {
       error += "Please Enter Credits."
       	   onsubmit1 = false;
    }
     error += "";
	document.getElementById('signupvalid').innerHTML = error;
    document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;
}


function checkAdmin()
{
    onsubmit1 = true;
    var error = ""

    if (trim( document.getElementById('admin_username').value)== 0) {
       error += "Please Enter Username."
       	   onsubmit1 = false;
    }
     if (trim( document.getElementById('admin_password').value)== 0) {
       error += "Please Enter Password."
       	   onsubmit1 = false;
    }
     error += "";
	document.getElementById('signupvalid').innerHTML = error;
    document.getElementById('signupvalid').style.display = "";
	if(onsubmit1)
	{
		document.getElementById('signupvalid').style.display = "none";
	}
	return onsubmit1;
}

function addNoteCounter(maxlimit) {
    field = document.getElementById('notes_notes');

    cntfield = document.getElementById('hcharLen');

    if (field.value.length > maxlimit) { // if too long...trim it!
        field.value = field.value.substring(0, maxlimit);
//document.getElementById('remLen1').innerHTML = field.value.substring(0, maxlimit);
    }
// otherwise, update 'characters left' counter
    else{
        cntfield.value = maxlimit - field.value.length;
        len = maxlimit - field.value.length;
        document.getElementById('charLen').innerHTML = len+" characters left";
    }
}

function addNotes()
{
    field = document.getElementById('notes_notes');
    $("#notes").val(field.value);
//    $("#add_notes").append('<input type="hidden" name="notes[]" value="' + field.value + '"/>')
    document.getElementById('divbox').style.display="none";
}

$(document).ready(function(){
	$("body").addClass("full_width");
	$("#sidebar h3").click(function() {
		$( "#sidebar .navigation" ).toggle();
	});
});