function setup_validations() {
  $( '.validate-presence' ).each(function() {
    $(this).blur(function() {
      $(this).parents('.field').find('.error_message').remove();
      if ($(this).val() == '') {
        $(this).parents('.field').append("<div class='error_message'>não pode ficar em branco</div>");
        $(this).parents('.field').addClass('invalid');            
      } else {
        $(this).parents('.field').removeClass('invalid');
      }
    });

    $(this).removeClass('validate-presence');
  });
}

$(document).ready(function () {
  setup_validations();
});
