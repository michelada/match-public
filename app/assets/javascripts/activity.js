$(document).on('turbolinks:load', function() {
  $('#activity_activity_type').on('change', function(ev) {
    renderFormBasedOnActivity();
  })

  renderFormBasedOnActivity();

  validateRequiredFields();

  validateRequiredFields();
})

function renderFormBasedOnActivity(){
  var textForLocationLabel = "";
  var textForLocationPlaceholder = "";
  var textPitchAudience = "";
  var textAbbstractOutline = "";
  switch($('#activity_activity_type :selected').text()){
    case "Post":
      textForLocationLabel = "Publicación";
      textForLocationPlaceholder = "¿En dónde se publicó?"
      removeLabelsAndInputs();
      break;
    case "Plática":
      textForLocationLabel = "Evento";
      textForLocationPlaceholder = "¿En dónde se impartió?";
      textPitchAudience = "Pitch";
      textAbbstractOutline = "Abstract";
      changeLabelsValues(textPitchAudience, textAbbstractOutline);
      addRemovedFields();
      break;
    case "Curso":
      textForLocationLabel = "Evento";
      textForLocationPlaceholder = "¿En dónde se impartió?";
      textPitchAudience = "Audiencia";
      textAbbstractOutline = "Guía";
      changeLabelsValues(textPitchAudience, textAbbstractOutline);
      addRemovedFields();
      break;
    default:
    break;
  }
  $('#other_location input').attr("placeholder", textForLocationPlaceholder);
  $('#other_location label').text(textForLocationLabel);
}

function changeLabelsValues(pitchAudienceText, abstractOutlineText) {
  $('.optional-fields #pitch-audience label').text(pitchAudienceText);
  $('.optional-fields #abstract-outline label').text(abstractOutlineText);
}

function removeLabelsAndInputs() {
  $('#pitch-audience, #abstract-outline, #description').hide();
}

function addRemovedFields(){
  $('#pitch-audience, #abstract-outline, #description').show();
}

function validateRequiredFields(){
  $('#submit_button').on('click', function(e){
    var error = ""
    var errorCount = 0;
    switch($('#activity_activity_type :selected').text()){
      case "Curso":
        if($('#activity_name').val() == ""){
          error += "\n-Nombre";
          errorCount++;
        }
        if($('#activity_description').val() == ""){
          error += "\n-Descripción";
          errorCount++;
        }
        if($('#activity_pitch_audience').val() == ""){
          error += "\n-Audiencia";
          errorCount++;
        }
        if($('#activity_abstract_outline').val() == ""){
          error += "\n-Guía";
          errorCount++;
        }
        if(errorCount > 0){
          e.preventDefault();
          e.stopImmediatePropagation();
          showErrorMessage(error, errorCount)
        }
      break;
      case "Plática":
        if($('#activity_name').val() == ""){
          error += "\n-Nombre";
          errorCount++;
        }
        if($('#activity_description').val() == ""){
          error += "\n-Descripción";
          errorCount++;
        }
        if($('#activity_pitch_audience').val() == ""){
          error += "\n-Pitch";
          errorCount++;
        }
        if($('#activity_abstract_outline').val() == ""){
          error += "\n-Abstract";
          errorCount++;
        }
        if(errorCount > 0){
          e.preventDefault();
          e.stopImmediatePropagation();
          showErrorMessage(error, errorCount)
        }
      break;
      case "Post":
        if($('#activity_name').val() == ""){
          error += "\nNombre";
          errorCount++;
          e.preventDefault();
          e.stopImmediatePropagation();
          showErrorMessage(error, errorCount)
        }else{
          $('#activity_description').val("");
          $('#activity_pitch_audience').val("");
          $('#activity_abstract_outline').val("");
        }
      default:
      break;
    }
  })
}

function showErrorMessage(errorString, errorCount){
  if(errorCount == 1){
    alert("El siguiente campo no puede estar en blanco: " + errorString);
  }else{
    alert("Los siguiente campos no pueden estar en blanco: " + errorString)
  }
}
