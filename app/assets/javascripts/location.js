$(document).on('turbolinks:load', function() {
  counter = 0;

  $('#add_location').on('click', function(ev) {
    ev.preventDefault();
    var activity = $('#activity_location').val();
    $('#locations_string').val($('#locations_string').val() + activity + ",")
    $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>')
    $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">')
    counter++;
  })

  $('#add_new').on('click', function(ev) {
    ev.preventDefault();
    var activity = $('#other_location input').val();
    $('#locations_string').val($('#locations_string').val() + activity + ",")
    $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>')
    $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">')
    $('#other_location input').val("")
    counter++;
  })
  
  $('.locations_list ul input').on('click', function(ev){
    ev.preventDefault();
    $('li, input').remove("#" + this.id)
    console.log(this.id);
  })
})