$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        eventSources: [{
        url: '/events.json',
    }],
    })

});
