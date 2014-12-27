function add_payment_item(payment_id) {
  var target      = $('tr#payment_' + payment_id + ' .payment_items')[0];
  var timestamp   = 'new_' + new Date().getTime();
  var new_id      = "payments_" + payment_id + "_payment_items_" + timestamp;
  var new_name    = "payments[" + payment_id + "][payment_items][" + timestamp + "]";
  var new_content = "<div class='row'>";
  new_content    += "  <div class='col w70'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <label for='"+ new_id +"_account_name'> Conta </label>";
  new_content    += "      <input class='selected_id' type='hidden' name='"+new_name+"[account_id]' id='"+new_id+"_account_id' value=''/>";
  new_content    += "      <input class='short autocomplete validate-presence' type='text' name='"+new_name+"[account_name]' id='"+new_id+"_account_name' value='' data-source='/admin/accounts.json'/> ";
  new_content    += "    </div>";
  new_content    += "  </div>";
  new_content    += "  <div class='col w25'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <label for='"+ new_id +"_value'> Valor </label>";
  new_content    += "      <input class='short right value' type='text' name='"+new_name+"[value]' id='"+new_id+"_value' value='0,00' onkeypress='mascara(this,dinheiro)'>";
  new_content    += "    </div>";
  new_content    += "  </div>";
  new_content    += "  <div class='col w5'>";
  new_content    += "    <div class='button button-small red middle trash'>";
  new_content    += "      <a href='javascript:;'>x</a>";
  new_content    += "    </div>";
  new_content    += "  </div>";
  new_content    += "</div>";
  
  $(target).append(new_content);
  setup_autocomplete();
  setup_trash_buttons();
  setup_validation();
  setup_ofx_validation();
}

function setup_trash_buttons() {
  $('.payment_items .row .button.trash').click(function(){ remove_payment_item(this) } );
}

function remove_payment_item(element) {
  var payment = $(element).parents('tr.payment');
  $(element).parents('.row').remove();
  validate_payment(payment);
}

function validate_payment(element) {
  var expected_value = parseMoney($(element).find('.payment_items').data('total'));
  var found_value    = 0;
  var elements       = $(element).find('.payment_items .value');
  for (var i = 0; i < elements.length; i++) {
    var v = $(elements[i]).val();
    found_value += parseMoney(v == '' ? 0 : v);
  }

  $(element).find('.payment_items').find('.ofx.error_message').remove();
  $(element).removeClass('invalid');

  // validate sum
  if (found_value != expected_value) {
    $(element).find('.payment_items').prepend("<div class='ofx error_message'>erro: a soma dá "+dinheiro_formatado(found_value)+" e não "+dinheiro_formatado(expected_value)+"</div>");
  }    
  
  if ($(element).find('.error_message').length > 0) {
    $(element).addClass('invalid');    
  }
}

function setup_ofx_validation() {
  $( "tr.payment input" ).blur(function(){
    validate_payment($(this).parents('tr.payment'));
  });
}

$(document).ready(function () {
  setup_ofx_validation();
});

