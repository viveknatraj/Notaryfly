

 jQuery.noConflict();
jQuery(document).ready(function(){

    
     checkPendingOrders();


 });

 function checkPendingOrders(){
 jQuery.ajax({
      url: "/notary/orders/pending_orders",
      dataType: 'script',
      type: "get",
//      data: {data:'hi'},
      data: {$(this).serialize()},
      success:function(){

         setTimeout(200000, checkPendingOrders());

      },
      error:function(){
         

      }
    });
 }

 