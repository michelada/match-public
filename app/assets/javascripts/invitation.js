$(document).on('turbolinks:load', function() {
  $('#validation-button').on('click',function(ev){
    if($('#user_password').val() == $('#user_password_confirmation').val()){
      if ($('#user_password').val().length > 5){
      }else{
        $('#label-password').removeAttr('hidden');
        $('#label-password').css("color", "red")
        $('#label-password-confirmation').removeAttr('hidden');
        $('#label-password-confirmation').css("color", "red")
        ev.preventDefault()
      }
    }else {
      ev.preventDefault()
      $('#label-password').removeAttr('hidden');
      $('#label-password').css("color", "red")
      $('#label-password-confirmation').removeAttr('hidden');
      $('#label-password-confirmation').css("color", "red")
    }
  })
});
