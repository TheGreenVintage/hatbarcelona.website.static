$(document).ready(function() {
  var $form = $('form#contact-form');

  $form.submit(function(event) {
    var formData = {
      name:    $form.find('[name=name]').val(),
      email:   $form.find('[name=email]').val(),
      phone:   $form.find('[name=phone]').val(),
      address: $form.find('[name=address]').val(),
      date:    $form.find('[name=date]').val(),
      message: $form.find('[name=message]').val()
    };

    $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: formData,
      dataType: 'json',
      encode: true
    }).fail(function(error){
      alert('Error:' + error);
    }).done(function(data){
      $('#contact-success').show();
      $('#contact-form').hide();
    });

    event.preventDefault();
  });
});
