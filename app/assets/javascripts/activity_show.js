$(document).on('turbolinks:load', function(){
  var currentEdition = null;

  $('.edit_comment a').on('click', function(ev){
    var id = $(this).attr('id');
    var editBtn = $('.edit_comment a#' + id);
    var commentEditor = $('textarea#editor_' + id);
    var commentText = $('p#comment_' + id);
    var originalText = $('input#originalText_' + id)

    if(currentEdition === null){
      ev.preventDefault();
      currentEdition = id;

      editBtn.text('Aceptar');
      commentText.hide();
      commentEditor.removeAttr('hidden');
      commentEditor.val(originalText.val());
    }else{
      if(currentEdition === id){
        currentEdition = null;
        var text = commentEditor.val();
        var authenticityToken = $("meta[name='csrf-token']").attr('content');
        editBtn.text('Editar');
        commentEditor.attr('hidden', 'true');
        commentText.show();
        var commentableId = $('.form_data #commentId' + id).val();
        var feedbackId = $('.form_data #feedbackId' + id).val();

        if(text != ""){
          commentText.text(text);
          $.ajax({
            type: 'PUT',
            url: (commentableId + '/feedbacks/' + feedbackId),
            data: {
              "authenticity_token": authenticityToken,
              "feedback": {"comment": text}
            },
            dataType: "json"
          });
        }
      }else{
        alert("Estas editando otro comentario");
        ev.stopImmediatePropagation();
      }
    }
  });

  var charsMD = {
    boldButton: ["****", 2, ''],
    italicButton: ["__", 1, ''],
    codeButton: ["``", 1, ''],
    linkButton: ["[LINK_NAME](http://YOUR_LINK)", 10, ''],
    quoteButton: [">", 0, '\n'],
    listButton: ["- \n-", 0, '\n']
  }


  $('.comment-actions a').on('click', function(ev) {
    var textarea = $('textarea#feedback_comment');
    var key = $(this).parent().attr('id');

    if(textarea.val() == ''){
      textarea.val(textarea.val() + charsMD[key][0]);
    }else{
      textarea.val(textarea.val() + charsMD[key][2] + charsMD[key][0]);
    }
    textarea.focus();
    textarea.setCursorPosition(textarea.val().length - charsMD[key][1]);

    ev.preventDefault();
  })

  $.fn.setCursorPosition = function(position) {
    this.each(function(index, element) {
      if (element.setSelectionRange) {
        element.setSelectionRange(position, position);
      } else if (element.createTextRange) {
        var range = element.createTextRange();
        range.collapse(true);
        range.moveEnd('character', position);
        range.moveStart('character', position);
        range.select();
      }
    });
    return this;
  };
});
