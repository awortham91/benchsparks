chosen_number = 3
var win = 0
var lose = 0
var i = 1

document.getElementById("input").onclick = function() {playOnesGame(Math.floor((Math.random() * 10) + 1))};
document.getElementById("ones").onclick = function() {playOnesGame(chosen_number)};
document.getElementById("choose_number").onclick = function() {choose_number()};

function playOnesGame(n) {
  user_id = document.getElementById("user").innerHTML;

  $.ajax({
    type: "PATCH",
     url: "/questions/" + user_id
  });


  var x = document.getElementById("counter").innerHTML;
  var x = (parseInt(x));
  var x = x += 1
  document.getElementById("counter").innerHTML = x;
var number = n;
var number_two = Math.floor((Math.random() * 10) + 1);
var input = prompt(number + '*' + number_two);
  if (Number(input) === (number * number_two)) {
    $.ajax({
      type: "PATCH",
       url: "/questions/" + user_id + "/correct"
    });
    var y = document.getElementById("round_won").innerHTML;
    var y = (parseInt(y));
    var y = y += 1
    document.getElementById("round_won").innerHTML = y;
    win ++;
    var again = confirm('nice JOB! you have won ' + Math.round(win/i * 100) + '%' + ' would you like to play again?' + '%');
    i++;
    if (again === true) {
      playOnesGame(chosen_number);
    };
  } else {
    $.ajax({
      type: "PATCH",
       url: "/questions/" + user_id + "/incorrect"
    });
    var z = document.getElementById("round_lost").innerHTML;
    var z = (parseInt(z));
    var z = z += 1
    document.getElementById("round_lost").innerHTML = z;
    var again = confirm('you suck at guessing! but you have won ' + Math.round(win/i * 100) + '%'  + ' would you like to play again?');
    i++;
    if (again === true) {
      playOnesGame(chosen_number);
    };
}};

function choose_number() {
  chosen_number = prompt('what number would you like to choose?');
  console.log(chosen_number);

    document.getElementById("selected_number").innerHTML = chosen_number;

};
