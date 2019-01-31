$(document).on('turbolinks:load', function() {
  $('#activity_activity_type').on('change', function(ev) {
    var text = "";
    var field2 = "";
    var field3 = "";
    switch($('#activity_activity_type :selected').text()){
      case "Post":
        text = "Publicación";
        removeLabelsAndInputs();
        break;
      case "Platica":
        text = "Locación";
        field2 = "Pitch";
        field3 = "Abstract";
        changeLabelsValues(field2, field3);
        addRemovedFields();
        break;
      case "Curso":
        text = "Locación";
        field2 = "Intended Audience";
        field3 = "Outline";
        changeLabelsValues(field2, field3);
        addRemovedFields();
        break;
      default:
      break;
    }

    $('.location-publication').text(text);
  })

  function changeLabelsValues(value1, value2) {
    $('.optional-fields #pitch-audience label').text(value1)
    $('.optional-fields #abstract-outline label').text(value2)
  }

  function removeLabelsAndInputs() {
    $('#pitch-audience').remove();
    $('#abstract-outline').remove();
  }

  function addRemovedFields(){
    if ($('.optional-fields').html().trim() == ""){
      $('.optional-fields').append('<div id="pitch-audience">\
        <div class="form-group text optional activity_pitch_audience">\
          <label class="form-control-label text optional" for="activity_pitch_audience">Pitch</label>\
          <textarea class="form-control text optional" name="activity[pitch_audience]" id="activity_pitch_audience"></textarea>\
        </div>\
      </div>\
      <div id="abstract-outline">\
        <div class="form-group text optional activity_abstract_outline">\
          <label class="form-control-label text optional" for="activity_abstract_outline">Abstract</label>\
          <textarea class="form-control text optional" name="activity[abstract_outline]" id="activity_abstract_outline"></textarea>\
        </div>\
      </div>');
    }
  }
})