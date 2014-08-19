$(document).ready(function() {
    var a = location.pathname;
    a = a + '/events.json';
    // page is now ready, initialize the calendar...
    console.log(a);
    $('#calendar').fullCalendar({
        header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek,agendaDay'
            },
        defaultView: 'agendaDay',
        height: 450,
        slotMinutes: 30,
        eventSources: [{
        url: a,
      }],
    })

});
