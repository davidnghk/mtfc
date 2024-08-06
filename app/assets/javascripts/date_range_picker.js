var date_range_picker;
date_range_picker = function() {
  $('.date-range-picker').each(function(){
    $(this).daterangepicker({
        timePicker: true,
        timePickerIncrement: 30,
        alwaysShowCalendars: true
    }, function(start_date, end_date, label) {
      $('.start_date_hidden').val(start_date.format('YYYY-MM-DD HH:mm'));
      $('.end_date_hidden').val(end_date.format('YYYY-MM-DD HH:mm'));
    });
  })
};
$(document).on('turbolinks:load', date_range_picker);