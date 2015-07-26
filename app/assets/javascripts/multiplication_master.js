$(document).ready(function() {
	if($('div').is('.multiplication_master')){


    document.getElementById("counter").onmouseover = function() {
      document.getElementById("ready_text").innerHTML = "Set?";
    }

    document.getElementById("counter").onmouseout = function() {
      document.getElementById("ready_text").innerHTML = "Ready?";
    }

    document.getElementById("counter").onclick = function() {master()};

    function master() {
      document.getElementById("get_ready2").style.display = "none";
      document.getElementById("countdown_wrapper").style.display = "block";
      document.getElementById("counter").innerHTML = 'Master!';
      document.getElementById('answer_form').className += ' outer_div';
      document.getElementById("answer_form").style.border = "5px solid #510EAB";
      document.getElementById("countdown_wrapper").style.background = "#3849B5";
      document.getElementById("points").innerHTML = 0;
      document.getElementById("total_right").innerHTML = 0;
      document.getElementById("total_wrong").innerHTML = 0;
      document.getElementById("stats").style.display = "none";
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
            var levelData = {
              "level": level,
              "score": document.getElementById("points").innerHTML
            };
            document.getElementById('answer_form').className -= ' outer_div';
            document.getElementById("counter").disabled = false;
            document.getElementById("answer_zone").style.display = "none";
            document.getElementById("stats").style.display = "block";
            document.getElementById("answer_form").style.border = "0 solid #EFA43";
            document.getElementById("countdown_wrapper").style.background = '#04839B';
            document.getElementById("level_select").style.visibility = "visible";
            document.getElementById("counter").innerHTML = "Start the timer!";
            $.ajax({
              type: "POST",
               url: "/timedpractices",
              contentType: "application/json",
              dataType: "json",
              data: JSON.stringify(levelData),
               success: function(response) {
                 console.log(response);
               },
               error: function(response) {
                 console.log(response)
               }
            });
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
        var level = document.getElementById("range").innerHTML;
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
              if (level === '1') {
                first = document.getElementById("first_num").innerHTML = easy()
                second = document.getElementById("second_num").innerHTML = easy()
              } else if (level === '2') {
                first = document.getElementById("first_num").innerHTML = medium()
                second = document.getElementById("second_num").innerHTML = medium()
              }  else {
                first = document.getElementById("first_num").innerHTML = hard()
                second = document.getElementById("second_num").innerHTML = hard()
              }
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
