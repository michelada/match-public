$(document).on('turbolinks:load', function() {
  //Checks if the form was loaded, and if it was, all locations are parsed into locations_string
  var load_string = $('#loaded_locations').val()

  //Sometimes this input field prints random values, guess this'll fix it
  $('#other_location input').val("")

  if(load_string !== ""){
    $('#locations_string').val(load_string)
    $('#loaded_locations').val("")
  }

  //When you add "other location", that location is not created. Instead, it's value is stored
  //in a hidden input named #locations_string. Therefore, you don't know if that value is going
  //to be deleted, or if it will be created on the database. This COUNTER variable creates a 
  //temporary ID for those items, so you can get a reference whenever you want to perform an action
  //on them. There might be a better way to do this, but i opted to do this.
  counter = 1000;

  //Handles items added from the select input.
  $('#add_location').on('click', function(ev) {
    ev.preventDefault();
    var activity = $('#activity_locations').val();
    var locString = $('#locations_string').val();

    if(locString.toLowerCase().includes(activity.toLowerCase())){
      alert("The element you're tryng to add is already on the list")
    }else{
      $('#locations_string').val(locString + activity + "ß");
      $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>');
      $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">');
      deleteLI();
      counter++;
    }
  })

  //Handles items added from the text input
  $('#add_new').on('click', function(ev) {
    ev.preventDefault();
    var textVal = $('#other_location input').val();
    var locString = $('#locations_string').val();
    var activity = $('#other_location input').val();

    if($(textVal) === ""){
      alert('You can leave this field blank')
    }else {
      if(locString.toLowerCase().includes(activity.toLowerCase())){
        alert("The element you're tryng to add is already on the list")
      }else{
        $('#locations_string').val(locString+ activity + "ß");
        $('.locations_list ul').append('<li id=' + counter + '>' + activity + '</li>');
        $('.locations_list ul').append('<input id=' + counter + ' type="button" value="-">');
        $('#other_location input').val("");
        deleteLI(); 
        counter++;
      }
    }
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
      $('#locations_string').val($('#locations_string').val().replace((value + "ß"),''));
    }

    $('li, input').remove("#" + this.id);
  })
}