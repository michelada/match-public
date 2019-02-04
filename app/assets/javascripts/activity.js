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
  $('#pitch-audience, #abstract-outline').hide();
}

function addRemovedFields(){
  if ($('.optional-fields').html().trim() == ""){
    $('.optional-fields').append('<div id="pitch-audience">\
      <div class="form-group text optional activity_pitch_audience">\
        <label class="form-control-label text optional" for="activity_pitch_audience">Pitch</label>\
        <textarea class="form-control text optional input-text" name="activity[pitch_audience]" id="activity_pitch_audience"></textarea>\
      </div>\
    </div>\
    <div id="abstract-outline">\
      <div class="form-group text optional activity_abstract_outline">\
        <label class="form-control-label text optional" for="activity_abstract_outline">Abstract</label>\
        <textarea class="form-control text optional input-text" name="activity[abstract_outline]" id="activity_abstract_outline"></textarea>\
      </div>\
    </div>');
  }
  $('#pitch-audience, #abstract-outline').show();
}
