var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      defaultView: 'agendaWeek',
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,  
      eventLimit: true,
      events: '/duties.json',

      select: function(start, end) {
        $.getScript('/duties/new', function() {
          $('#duty_date_range').val(moment(start).format("YYYY-MM-DD HH:mm") + ' - ' + moment(end).format("YYYY-MM-DD HH:mm"))
          date_range_picker();
          $('.start_date_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_date_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });
        
        calendar.fullCalendar('unselect');
      },

      eventDrop: function(duty, delta, revertFunc) {
        duty_data = { 
          duty: {
            id: duty.id,
            date_range: duty.start.format("YYYY-MM-DD HH:mm") + ' - ' + duty.end.format("YYYY-MM-DD HH:mm"), 
            start_date: duty.start.format(),
            end_date: duty.end.format()
          }
        };
        $.ajax({
            url: duty.update_url,
            data: duty_data,
            type: 'PATCH'
        });
      },
      
      eventClick: function(duty, jsEvent, view) {
        $.getScript(duty.edit_url, function() {
          $('#duty_date_range').val(moment(duty.start).format("YYYY-MM-DD HH:mm") + ' - ' + moment(duty.end).format("YYYY-MM-DD HH:mm"))
          date_range_picker();
          $('.start_date_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_date_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);

