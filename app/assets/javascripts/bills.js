var filter = function () {
  var currentDate = moment();
  var beginingOfMonth = currentDate.set('date',1).set('hour',0).set('minute',0).set('second',0)
  var bills = document.querySelectorAll(".bills");

  var i = 0
  var date = new Date(bills[0].children[5].innerHTML)
  while ( date >= beginingOfMonth) {
    bills[i].classList.remove("sr-only");
    i++;
    date = new Date(bills[i].children[5].innerHTML)
  }
};

var hideAll = function(){
  var bills = document.querySelectorAll(".bills");

  for (var i = 0; i < bills.length; i++) {
    bills[i].classList.add("sr-only");
  };
}

var passMonthFilter = function(){
  hideAll();
  var currentDate = new Date(document.getElementById("current-date").innerHTML);
  var beginingOfMonth = new Date(currentDate.getFullYear(),(currentDate.getMonth()-1),1,2);
  var endOfMonth = new Date(currentDate.getFullYear(),(currentDate.getMonth()),1);
  endOfMonth.setDate(endOfMonth.getDate()-1);

  var bills = document.querySelectorAll(".bills");
  var date
  for (var i = 0; i < bills.length; i++) {
    date = new Date(bills[i].children[5].innerHTML)
    if (date >= beginingOfMonth && date <= endOfMonth) {
      bills[i].classList.remove("sr-only");
    }
  };
  var stringDate = beginingOfMonth.toUTCString().split(" ")
  document.getElementById("current-date").innerHTML = beginingOfMonth.toString()
  document.getElementById("month").innerHTML = stringDate[2] + " - " + stringDate[3];
}

var nextMonthFilter = function(){
  hideAll();
  var currentDate = new Date(document.getElementById("current-date").innerHTML);
  var beginingOfMonth = new Date(currentDate.getFullYear(),(currentDate.getMonth()+1),1,2);
  var endOfMonth = new Date(currentDate.getFullYear(),(beginingOfMonth.getMonth()+1),1);
  endOfMonth.setDate(endOfMonth.getDate()-1);

  var bills = document.querySelectorAll(".bills");
  var date
  for (var i = 0; i < bills.length; i++) {
    date = new Date(bills[i].children[5].innerHTML)
    if (date >= beginingOfMonth && date <= endOfMonth) {
      bills[i].classList.remove("sr-only");
    }
  };
  var stringDate = beginingOfMonth.toUTCString().split(" ")
console.log(beginingOfMonth);
  console.log(stringDate);
  document.getElementById("current-date").innerHTML = beginingOfMonth.toString()
  document.getElementById("month").innerHTML = stringDate[2] + " - " + stringDate[3];
}

window.onload = filter;

var nextMonth = document.getElementById("next-month");
var prevMonth = document.getElementById("prev-month");

nextMonth.addEventListener("click", nextMonthFilter)
prevMonth.addEventListener("click", passMonthFilter)



