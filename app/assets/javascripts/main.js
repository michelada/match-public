$(document).on('turbolinks:load', function() {
  var collapsed = true;
  $('.break-arrow').on('click', function() {
    if (collapsed){
      $('div .collapsed-teams').addClass('expanded');
      $('.break-arrow').addClass('expanded');
      collapsed = false;
    }else {
      $('div .collapsed-teams').removeClass('expanded');
      $('.break-arrow').removeClass('expanded');
      collapsed = true;
    }
  })
})