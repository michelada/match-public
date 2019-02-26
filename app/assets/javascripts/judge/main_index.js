$(document).on('turbolinks:load', function(){
  $('.activitiesContainer').hide();
  $('.activitiesContainer:first').show();

  $('a.button.pill').on('click', function(ev){
    ev.preventDefault();
    $('a.activePill').removeClass('activePill');
    $(this).addClass('activePill');
    $('div.activitiesContainer').hide();
    $($(this).attr('href')).show();
  })

})
