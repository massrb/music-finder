// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'jquery'
// import "script"
//import './add_jquery'

$(document).on('change', '.profile-checkbox', function() {
  let checked = $(this).is(':checked');
  let itemId = $(this).data('id'); // Get ID from data attribute
  let csrfToken = $('meta[name="csrf-token"]').attr('content'); 

  $.ajax({
    url: '/profiles/update_selected', // Adjust to your actual route
    type: 'PATCH',
    data: { selected: checked, id: itemId },
    headers: { 'X-CSRF-Token': csrfToken },
    dataType: 'json',
    success: function(response) {
      console.log("Status updated:", response);
    },
    error: function(xhr) {
      console.log("Error:", xhr.responseText);
    }
  });
});