$('.sidebar-bottom-right').hover(
  function(){
  $('.sidebar-bottom-right').addClass('sidebar-bottom-right-active').removeClass('sidebar-bottom-right');
  },
  function(){
  $('.sidebar-bottom-right-active').addClass('sidebar-bottom-right').removeClass('sidebar-bottom-right-active');
  }
);
$('.sidebar-bottom-left').hover(
  function(){
    $('.sidebar-bottom-left').addClass('sidebar-bottom-left-active').removeClass('sidebar-bottom-left');
  },
  function(){
    $('.sidebar-bottom-left-active').addClass('sidebar-bottom-left').removeClass('sidebar-bottom-left-active');
  }
);
