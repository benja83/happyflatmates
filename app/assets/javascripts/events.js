$(document).ready(function () {
    var a = location.pathname;
    a = a + '/events.json';
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
        header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek,agendaDay'
            },
        allDayDefault: false,
        defaultView: 'agendaDay',
        height: 450,
        slotMinutes: 30,
        selectable: true,
        select: function (start, end) {
          $('#side-event').removeClass('sr-only');
          var title = 'TEST';
          var eventData;
          if (title) {
            eventData = {
              title: title,
              start: start,
              end: end
            };
            $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
          }
          $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        eventSources: [{
        url: a,
        }]

    })

});
