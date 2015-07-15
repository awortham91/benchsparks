$(document).ready(function() {
	if($('div').is('.time_game')){

    document.getElementById("counter").onclick = function() {countdown()};

    function countdown() {
      document.getElementById("points").innerHTML = 0;
      document.getElementById("total_right").innerHTML = 0;
      document.getElementById("total_wrong").innerHTML = 0;
      document.getElementById("stats").style.display = "none";
      first = document.getElementById("first_num").innerHTML = Math.floor((Math.random() * 10) + 1)
      second = document.getElementById("second_num").innerHTML = Math.floor((Math.random() * 10) + 1)
      toggle_away();
      document.getElementById("counter").disabled = true;
        var seconds = 61;
        function tick() {
            var counter = document.getElementById("countdown");
            seconds--;
            counter.innerHTML = (seconds < 10 ? "0" : "") + String(seconds);
            if( seconds > 0 ) {
                setTimeout(tick, 1000);
            } else {
              document.getElementById("counter").disabled = false;
              document.getElementById("answer_zone").style.display = "none";
              document.getElementById("stats").style.display = "block";
            };
        };
        tick();

    };

    function toggle_away() {
      document.getElementById("answer_zone").style.display = "block";
      document.getElementById("info").style.display = "block";
    };

    $(function() {
      $(".sub_button").click(function() {
        if ($('#answer_area').val() != '') {
          var user_id = document.getElementById("user").innerHTML;
          var answer=$('#answer_area').val();
          var data = {
            "body": first + " * " + second,
            "answer": answer
          };
          $.ajax({
            type: 'POST',
            url:  "/userquestions",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(data),
            success: function(response) {
              $.ajax({
                type: "PATCH",
                 url: "/questions/" + user_id,
                 success: function(response) {
                   console.log(response);
                 },
                 error: function(response) {
                   console.log(response)
                 }
              });
              console.log(response)
              first = document.getElementById("first_num").innerHTML = Math.floor((Math.random() * 10) + 1)
              second = document.getElementById("second_num").innerHTML = Math.floor((Math.random() * 10) + 1)
              var totals = document.getElementById("points").innerHTML;
              var totals = (parseInt(totals));
              var correct = document.getElementById("total_right").innerHTML;
              var correct = (parseInt(correct));
              var incorrect = document.getElementById("total_wrong").innerHTML;
              var incorrect = (parseInt(incorrect));
              if (response.statusText === 'correct') {
                var totals = totals += 1
                var correct = correct += 1
                $.ajax({
                  type: "PATCH",
                   url: "/questions/" + user_id + "/correct",
                   success: function(response) {
                     console.log(response);
                   },
                   error: function(response) {
                     console.log(response)
                   }
                });
              } else {
                var totals = totals -= 1
                var incorrect = incorrect += 1
                $.ajax({
                  type: "PATCH",
                   url: "/questions/" + user_id + "/incorrect",
                   success: function(response) {
                     console.log(response);
                   },
                   error: function(response) {
                     console.log(response)
                   }
                });
              };
              document.getElementById("points").innerHTML = totals;
              document.getElementById("total_right").innerHTML = correct;
              document.getElementById("total_wrong").innerHTML = incorrect;
            },
            error: function(response) {
              console.log(response)
            }
          });
          $("#answer_area").val('');
        };
        return false;
      });
    });

  };
});
