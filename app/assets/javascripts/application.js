// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require datatables
//= require toastr
//= require jquery-ui
//= require jquery_ujs
// require data-confirm-modal
//= require local-time
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
// require cable
//= require Chart.bundle
//= require chartkick
//= require jquery-ui
//= require moment
//= require fullcalendar 
//= require fullcalendar/locale-all
//= require_tree .

jQuery(function($) {
    $("tr[data-link]").click(function() {
		// Same tab call :
          window.location = $(this).data('link');
        // New tab call: 
        //  window.open($(this).data('link'),"_Blank");
    });
});

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}

$(document).ready( function () {
    $('#guestrooms').DataTable();
} );

$(document).ready( function () {
    $('#workflow').DataTable();
} );

$(document).ready( function () {
    $('#masters').DataTable();
} );

$(document).ready( function () {
    $('#businessStaffs').DataTable();
} );

$(document).on('turbolinks:load', function() {

  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
  
});
