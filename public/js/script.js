/* Author:

*/

$('.thanks').live('click', function() {
  $('#thanks').slideToggle("hidden");
  $('html, body').animate({ scrollTop: $('#scroll_target').offset().top });
  return false;
});





//$('html, body').animate({ 
//scrollTop: $('#yourDiv').offset().top 
//}, 3000);
