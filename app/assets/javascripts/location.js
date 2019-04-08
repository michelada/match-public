$(document).on('turbolinks:load', function() {
  //SET AUXILIAR VALUE DEPENDING OF THE REDERED VIEW CONTENT
  $('#location_inputs').attr('value', $('#location_inputs div').length)


  $('#add_location_input').on('keypress', function(event) {
    if (event.charCode === 13) {
      event.preventDefault();
      if($('#other_location input').val() != ""){
        addLocation();
      }
    }
  });

  $('#add_location_input').on('focusout', function(event) {
    if($('#other_location input').val() !== ""){
      addLocation();
        return true;
      }
  });



  deleteLI();
  //IF THE NUMBER OF TAGS EQUALS NUMBER OF FORMS, REQUEST A NEW FORM
  if($('.locations_list ul li').length == $('#location_inputs div').length ){
    obtainLocationForm();
  }

})

function deleteLI(){
  $('.locations_list a').on('click', function(ev){
    ev.preventDefault();
    var self = this;
    var event = $(this).parent().text().slice(0,-1).trim();
    $('#location_inputs input').each(function(){
      if($(this).val() == event ){
        $(self).parent().remove();
        $(this).val("");
        return false;
      }
    });
  })
}

function addLocation() {
  var newLocation = $('#other_location input').val().trim();

  if (locationIsNotDuplicated(newLocation)){
    $('#location_inputs input').each(function(){
      if ($(this).val() == ''){
        $(this).val(newLocation);
        $('.locations_list ul').append('<li>' + newLocation + '<a>x</a></li>');
        $('#other_location input').val('');
        obtainLocationForm()
        return false;
      }
    });
    deleteLI()
  }else{
    alert('Esta opción ya ha sido seleccionada');
    $('#other_location input').val('');
  }
}

function obtainLocationForm(){
  $.ajax({
    url: '/location/new',
    method: 'get',
    dataType: 'html',
    data: {index: $('#location_inputs').attr('value') },
    success: function(response){
      $('#location_inputs').append(response)
      $('#location_inputs').attr('value', $('#location_inputs div').length)
    }
  })
}

function locationIsNotDuplicated(newLocation){
  var isNotDuplicated = true;

  $('#location_inputs input').each(function(){
    if($(this).val() == newLocation){
      isNotDuplicated = false;
      return true
    }
  })
  return isNotDuplicated;
}

