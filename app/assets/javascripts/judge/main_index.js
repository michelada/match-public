$(document).on('turbolinks:load', function(){
  $('.activitiesContainer').hide();
  $('.activitiesContainer:first').show();
  $('a.activePill').css('color','#FFD557');

  $('a.button.pill').on('click', function(ev){
    ev.preventDefault();
    $('a.activePill').css('color','#fff');
    $('a.activePill').removeClass('activePill');
    $(this).addClass('activePill');
    $(this).css('color','#FFD557');
    $('div.activitiesContainer').hide();
    $($(this).attr('href')).show();
  })
})
