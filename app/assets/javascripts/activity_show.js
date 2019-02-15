$(document).on('turbolinks:load', function(){
  var currentEdition = null;

  $('.edit_comment a').on('click', function(ev){
    var id = $(this).attr('id');
    var editBtn = $('.edit_comment a#' + id);
    var commentEditor = $('input#editor_' + id);
    var commentText = $('p#comment_' + id);

    if(currentEdition === null){
      ev.preventDefault();
      currentEdition = id;

      editBtn.text('Aceptar');
      commentText.hide();
      commentEditor.removeAttr('hidden');
    }else{
      if(currentEdition === id){
        currentEdition = null;
        var text = commentEditor.val();
        var authenticityToken = $("meta[name='csrf-token']").attr('content');
        editBtn.text('Editar');
        commentEditor.attr('hidden', 'true');
        commentText.show();
        commentText.text(text);
        var activityId = $('.form_data #acId' + id).val();
        var feedbackId = $('.form_data #fbId' + id).val();

        $.ajax({
          type: 'PUT',
          url: (activityId + '/feedbacks/' + feedbackId),
          data: {
            "authenticity_token": authenticityToken,
            "comment": text},
          dataType: "json"
        });

        ev.preventDefault();
      }else{
        alert("Estas editando otro comentario");
        ev.preventDefault();
      }
    }
  });
});