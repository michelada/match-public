$(document).on('turbolinks:load', function() {
  //Checks if the form was loaded, and if it was, all locations are parsed into locations_string
  var load_string = $('#loaded_locations').val()
  if(load_string !== ""){
    $('#locations_string').val(load_string)
    $('#loaded_locations').val("")
  }

  counter = 100;

  //Handles items added from the select input.
  $('#add_location').on('click', function(ev) {
    ev.preventDefault();
    var activity = $('#activity_location').val();
    $('#locations_string').val($('#locations_string').val() + activity + ",");
    $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>');
    $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">');
    deleteLI();
    counter++;
  })

  //Handles items added from the text input
  $('#add_new').on('click', function(ev) {
    ev.preventDefault();
    var activity = $('#other_location input').val();
    $('#locations_string').val($('#locations_string').val() + activity + ",");
    $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>');
    $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">');
    $('#other_location input').val("");
    deleteLI();
    counter++;
  })
  
  deleteLI();
})

//Until now, "added" locations only exist on the html view and inside a locations_string
//This method removes the html elements that belong to that item, and deletes it from the string
function deleteLI(){
  $('.locations_list input').on('click', function(ev){
    ev.preventDefault();
    var value = ($(('li#' + this.id)).text());
    
    if(value !== ""){
      $('#locations_string').val($('#locations_string').val().replace((value + ","),''));
    }

    $('li, input').remove("#" + this.id);
  })
}