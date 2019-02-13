$(document).on('turbolinks:load', function() {
  changeButtonStyle($(location).attr('pathname'))
});



function changeButtonStyle(pendingActivities){
  if(pendingActivities == '/judge/main'){
    $('#pendingActivitiesSectionButton').addClass('text yellow')
    $('#allActivitiesSectionButton').removeClass('text yellow')
	
  }else{
    $('#allActivitiesSectionButton').addClass('text yellow')
    $('#pendingActivitiesSectionButton').removeClass('text yellow')
  }
}
