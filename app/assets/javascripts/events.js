$(document).ready(function () {
    var urlJsonBuilder = location.pathname;
    urlJsonBuilder = urlJsonBuilder + '/events.json';
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

          $('#side-event').addClass('sidebar-left-active').removeClass('sr-only');
          // var title = 'TEST';
          // var eventData;
          // if (title) {
          //   eventData = {
          //     title: title,
          //     start: start,
          //     end: end
          //   };
          //   $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
          // }
          // $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        eventSources: [{
        url: urlJsonBuilder,
        }]

    })


});
var closeForm = function(){
      $('#side-event').addClass('sr-only').removeClass('sidebar-left-active');
    };