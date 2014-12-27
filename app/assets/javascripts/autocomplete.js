function setup_autocomplete() {
  $( ".autocomplete" ).each(function() {
    var source = $(this).data('source');
    $(this).autocomplete({
      source: source,
      minLength: 3,
      search: function( event, ui ) {
        $(this).addClass('ui-autocomplete-loading');
      },
      response: function( event, ui ) {
        $(this).removeClass('ui-autocomplete-loading');
      },
      select: function( event, ui ) {
        if (ui.item) {
          $(this).val(ui.item.value);
          $(this).siblings('.selected_id').val(ui.item.id);        
        } else {
          $(this).siblings('.selected_id').val('');
        }
      }
    });
    
    $(this).removeClass('autocomplete');
  });
}

$(document).ready(function () {
  setup_autocomplete();
});
