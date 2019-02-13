$(document).on('turbolinks:load', function() {
  $('#activity_activity_type').on('change', function(ev) {
    renderFormBasedOnActivity();
  })

  renderFormBasedOnActivity();

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
      textPitchAudience = "Pitch *";
      textAbbstractOutline = "Resumen *";
      changeLabelsValues(textPitchAudience, textAbbstractOutline);
      addRemovedFields();
      break;
    case "Curso":
      textForLocationLabel = "Evento";
      textForLocationPlaceholder = "¿En dónde se impartió?";
      textPitchAudience = "Audiencia *";
      textAbbstractOutline = "Guía *";
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

