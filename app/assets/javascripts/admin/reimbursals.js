function add_payment_item() {
  var target      = $('.payment_items')[0];
  var timestamp   = 'new_' + new Date().getTime();
  var new_id      = "form_payment_items_" + timestamp;
  var new_name    = "form[payment_items][" + timestamp + "]";
  var new_content = "<tr class='payment_item' id='payment_item_" + new_id + "'>";
  new_content    += "  <td class='center'>&nbsp;</td>";
  new_content    += "  <td class='left'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <input class='selected_id' type='hidden' name='"+new_name+"[customer_id]' id='"+new_id+"_customer_id' value=''/>";
  new_content    += "      <input class='short autocomplete validate-presence' type='text' name='"+new_name+"[customer_name]' id='"+new_id+"_customer_name' value='' data-source='/admin/customers.json'/> ";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "  <td class='left'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <input type='text' class='short' id='"+new_id+"_description' name='"+new_name+"[description]'/>";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "  <td class='left'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <input class='selected_id' type='hidden' name='"+new_name+"[account_id]' id='"+new_id+"_account_id' value=''/>";
  new_content    += "      <input class='short autocomplete validate-presence' type='text' name='"+new_name+"[account_name]' id='"+new_id+"_account_name' value='' data-source='/admin/accounts.json?is_reimbursal=1'/> ";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "  <td class='center'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <input type='radio' name='"+new_name+"[request_refund]' id='"+new_id+"_request_refund_true' value='true'/>";
  new_content    += "      <label for='"+ new_id +"_request_refund_true'> Extra </label>";
  new_content    += "      &nbsp;&nbsp;";
  new_content    += "      <input type='radio' name='"+new_name+"[request_refund]' id='"+new_id+"_request_refund_false' value='false'/>";
  new_content    += "      <label for='"+ new_id +"_request_refund_false'> Interno </label>";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "  <td class='right'>";
  new_content    += "    <div class='field'>";
  new_content    += "      <input class='short right value' type='text' name='"+new_name+"[value]' id='"+new_id+"_value' value='0,00' onkeypress='mascara(this,dinheiro)'>";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "  <td class='center'>";
  new_content    += "    <div class='button red middle trash'>";
  new_content    += "      <a href='javascript:;'>x</a>";
  new_content    += "    </div>";
  new_content    += "  </td>";
  new_content    += "</tr>";
  
  $(target).append(new_content);
  setup_autocomplete();
  setup_trash_buttons();
  setup_validation();
}

function setup_trash_buttons() {
  $('.payment_items .button.trash').click(function(){ remove_payment_item(this) } );
}

function remove_payment_item(element) {
  var payment_items = $(element).parents('.payment_items');
  if ($(element).find('.delete').length > 0) {
    $(element).find('.delete').val(1);
    $(element).parents('tr.payment_item').hide();    
  } else {
    $(element).parents('tr.payment_item').remove();    
  }
  validate_payment(payment_items);
}

$(document).ready(function () {
  setup_trash_buttons();
});
