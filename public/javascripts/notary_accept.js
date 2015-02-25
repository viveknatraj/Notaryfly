

 jQuery.noConflict();
jQuery(document).ready(function(){

    
     checknotary_accepted();


 });

 function checknotary_accepted(){
 jQuery.ajax({
      url: "/client/orders/find_notary/1237",
      dataType: 'script',
      type: "get",
      data: {data:'hi'},
      success:function(){
         
      
         setTimeout(200000, checkPendingOrders());

      },
      error:function(){
         

      }
    });
 }