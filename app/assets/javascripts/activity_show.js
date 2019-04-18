$(document).on('turbolinks:load', function(){
  var currentEdition = null;

  $('.edit_comment a').on('click', function(ev){
    var id = $(this).attr('id');
    var editBtn = $('.edit_comment a#' + id);
    var commentEditor = $('textarea#editor_' + id);
    var commentText = $('p#comment_' + id);

    if(currentEdition === null){
      ev.preventDefault();
      currentEdition = id;

      editBtn.text('Aceptar');
      commentText.hide();
      commentEditor.removeAttr('hidden');
      commentEditor.val(commentText.text().trim());
    }else{
      if(currentEdition === id){
        currentEdition = null;
        var text = commentEditor.val();
        var authenticityToken = $("meta[name='csrf-token']").attr('content');
        editBtn.text('Editar');
        commentEditor.attr('hidden', 'true');
        commentText.show();
        var activityId = $('.form_data #acId' + id).val();
        var feedbackId = $('.form_data #fbId' + id).val();

        if(text != ""){
          commentText.text(text);
          $.ajax({
            type: 'PATCH',
            url: (activityId + '/feedbacks/' + feedbackId),
            data: {
              "authenticity_token": authenticityToken,
              "feedback": {"comment": text}
            },
            dataType: "json"
          });
        }

        ev.preventDefault();
      }else{
        alert("Estas editando otro comentario");
        ev.stopImmediatePropagation();
        ev.preventDefault();
      }
    }
  });
});
