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

      console.log("edit" + id);
      editBtn.text("Aceptar");
      commentText.hide();
      commentEditor.removeAttr('hidden');
    }else{
      if(currentEdition === id){
        $.ajax({
          type: "PUT",
          url: '/activities/1/feedbacks',
          data: {
            "comment": 'SOMETHING'
          },
          success: function() {
            console.log('SUCCESS');
          },
          dataType: 'json'
        });
        currentEdition = null;
        var text = commentEditor.val();

        editBtn.text("Editar");
        commentEditor.attr('hidden', 'true');
        commentText.show();
        commentText.text(text);
        console.log("Comment updated");
        ev.preventDefault();
      }else{
        alert("Estas editando otro comentario");
        ev.preventDefault();
      }
    }
  });
});