var initialize_calendar;
initialize_calendar = function() {
  $('.taskcalendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      minTime: "09:00:00",
      maxTime: "20:00:00",
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
      events: '/assignments.json',

      select: function(start, end) {
        $.getScript('/assignments/new', function() {
          $('#assignment_date_range').val(moment(start).format("YYYY-MM-DD HH:mm") + ' - ' + moment(end).format("YYYY-MM-DD HH:mm"))
          date_range_picker();
          $('.start_datetime_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.due_datetime_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });
        
        calendar.fullCalendar('unselect');
      },

      eventDrop: function(assignment, delta, revertFunc) { 
        assignment_data = { 
          assignment: {
            id: assignment.id,
            date_range: assignment.start.format("YYYY-MM-DD HH:mm") + ' - ' + assignment.end.format("YYYY-MM-DD HH:mm"), 
            start_datetime: assignment.start.format(),
            due_datetime: assignment.end.format()
          }
        };
        $.ajax({
            url: assignment.update_url,
            data: assignment_data,
            type: 'PATCH'
        });
      },
      
      eventClick: function(assignment, jsEvent, view) {
        $.getScript(assignment.edit_url, function() {
          $('#assignment_date_range').val(moment(assignment.start).format("YYYY-MM-DD HH:mm") + ' - ' + moment(assignment.end).format("YYYY-MM-DD HH:mm"))
          date_range_picker();
          $('.start_datetime_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_datetime_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
