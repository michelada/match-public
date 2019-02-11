document.addEventListener('turbolinks:load', function() {
  setTimeout(() => {
    $('.alert').fadeOut();
  }, 5000);
});