$(document).ready(function() {
  $('form#contact-form').submit(function(e) {
    e.preventDefault();

    var $form = $(this);
    $.post($form.attr("action"), $form.serialize()).then(function() {
      $('#contact-success').show();
      $('#contact-form').hide();
    });
  });
});
