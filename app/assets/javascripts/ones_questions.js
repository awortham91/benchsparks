$(document).ready(function() {
	if($('div').is('.practice')){

    chosen_number = 3
    var win = 0
    var lose = 0
    var i = 1

    document.getElementById("input").onclick = function() {playOnesGame(Math.floor((Math.random() * 10) + 1))};
    document.getElementById("ones").onclick = function() {playOnesGame(chosen_number)};
    document.getElementById("choose_number").onsubmit = function() { return choose_number()};
    document.getElementById("paractice_answer_zone").onsubmit = function() { return submit_practice_answer()};

    function playOnesGame(n) {
      document.getElementById("color_answer").innerHTML = '';
      document.getElementById("practice_answer_area").value = '';
      document.getElementById("practice_answer_area").style.display = "block";
      var number = n;
      var number_two = Math.floor((Math.random() * 10) + 1);
      document.getElementById("practice_one").innerHTML = number;
      document.getElementById("practice_two").innerHTML = number_two;
      document.getElementById("practice_answer_area").focus();
    };

    function submit_practice_answer() {
      if ($('#practice_answer_area').val() != '') {
        document.getElementById("color_answer").innerHTML = $('#practice_answer_area').val();
        user_id = document.getElementById("user").innerHTML;
        var number = parseInt(document.getElementById("practice_one").innerHTML);
        var number_two = parseInt(document.getElementById("practice_two").innerHTML);
        $.ajax({
          type: "PATCH",
           url: "/questions/" + user_id
        });
        var x = document.getElementById("counter").innerHTML;
        var x = (parseInt(x));
        var x = x += 1
        document.getElementById("counter").innerHTML = x;
        var input = $('#practice_answer_area').val()
        if (Number(input) === (number * number_two)) {
          document.getElementById("color_answer").style.backgroundColor = "green";
          $.ajax({
            type: "PATCH",
             url: "/questions/" + user_id + "/correct"
          });
          var y = document.getElementById("round_won").innerHTML;
          var y = (parseInt(y));
          var y = y += 1
          document.getElementById("round_won").innerHTML = y;
          win ++;
          var response = ('Nice work! you have won ' + Math.round(win/i * 100) + '% this round.');
          document.getElementById("cool_text").innerHTML = response;
          i++;
        } else {
          document.getElementById("color_answer").style.backgroundColor = "green";
          $.ajax({
            type: "PATCH",
             url: "/questions/" + user_id + "/incorrect"
          });
          var z = document.getElementById("round_lost").innerHTML;
          var z = (parseInt(z));
          var z = z += 1
          document.getElementById("round_lost").innerHTML = z;
          var response = ('Better luck next time! but you have won ' + Math.round(win/i * 100) + '% this round.');
          document.getElementById("cool_text").innerHTML = response;
          i++;
        };
        document.getElementById("practice_answer_area").style.display = "none";
        return false;
      };

      function choose_number() {
        if ($('#chosen_number_form').val() != '') {
          chosen_number = $('#chosen_number_form').val();
          console.log(chosen_number);
          document.getElementById("selected_number").innerHTML = chosen_number;
          document.getElementById("chosen_number_form").value = '';
        };
      };
      return false;
    };

  };
});
