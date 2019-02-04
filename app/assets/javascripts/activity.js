$(document).on('turbolinks:load', function() {
  $('#activity_activity_type').on('change', function(ev) {
    renderFormBasedOnActivity();
  })

  renderFormBasedOnActivity();
})

function renderFormBasedOnActivity(){
  var textForLocationLabel = "";
  var textPitchAudience = "";
  var textAbbstractOutline = "";
  switch($('#activity_activity_type :selected').text()){
    case "Post":
      textForLocationLabel = "Publicación";
      removeLabelsAndInputs();
      break;
    case "Plática":
      textForLocationLabel = "Evento";
      textPitchAudience = "Pitch";
      textAbbstractOutline = "Abstract";
      changeLabelsValues(textPitchAudience, textAbbstractOutline);
      addRemovedFields();
      break;
    case "Curso":
      textForLocationLabel = "Evento";
      textPitchAudience = "Audiencia";
      textAbbstractOutline = "Guía";
      changeLabelsValues(textPitchAudience, textAbbstractOutline);
      addRemovedFields();
      break;
    default:
    break;
  }

  $('.location-publication').text(textForLocationLabel);
}

function changeLabelsValues(pitchAudienceText, abstractOutlineText) {
  $('.optional-fields #pitch-audience label').text(pitchAudienceText);
  $('.optional-fields #abstract-outline label').text(abstractOutlineText);
}

function removeLabelsAndInputs() {
  $('#pitch-audience, #abstract-outline, #description').hide();
}

function addRemovedFields(){
  if ($('.optional-fields').html().trim() == ""){
    $('#pitch-audience, #abstract-outline, #description').show();
  }
}
