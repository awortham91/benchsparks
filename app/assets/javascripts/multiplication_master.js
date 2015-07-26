$(document).ready(function() {
	if($('div').is('.multiplication_master')){
    var seconds = 4;
		var first = document.getElementById("first_num").innerHTML = " "
		var second = document.getElementById("second_num").innerHTML = " "
    document.getElementById("counter").onmouseover = function() {
      document.getElementById("ready_text").innerHTML = "Set?";
    }

    document.getElementById("counter").onmouseout = function() {
      document.getElementById("ready_text").innerHTML = "Ready?";
    }

    document.getElementById("counter").onclick = function() {master()};

    function master() {
			document.getElementById("master_title").style.display = "none";
			document.getElementById("master_info").style.display = "none";
			document.getElementById("countdown").innerHTML = 0
      document.getElementById("get_ready2").style.display = "none";
      document.getElementById("countdown_wrapper").style.display = "block";
      document.getElementById("counter").innerHTML = 'Master!';
      document.getElementById('answer_form').className += ' outer_div';
      document.getElementById("answer_form").style.border = "5px solid #510EAB";
      document.getElementById("countdown_wrapper").style.background = "#3849B5";
			document.getElementById("answer_zone").style.display = "block";
			document.getElementById("info").style.display = "block";
			first = document.getElementById("first_num").innerHTML = Math.floor((Math.random() * 10) + 1);
			second = document.getElementById("second_num").innerHTML = Math.floor((Math.random() * 10) + 1);

      document.getElementById("counter").disabled = true;
      seconds = 5;
      function tick() {
        var counter = document.getElementById("countdown");
        seconds--;
        if( seconds > 0 ) {
          setTimeout(tick, 1000);
        } else {
          var levelData = {
            "level": "4",
            "score": document.getElementById("countdown").innerHTML
          };
          document.getElementById('answer_form').className -= ' outer_div';
          document.getElementById("counter").disabled = false;
          document.getElementById("master_title").style.display = "block";
					document.getElementById("master_info").style.display = "block";
					document.getElementById("answer_zone").style.display = "none";
          document.getElementById("answer_form").style.border = "0 solid #EFA43";
          document.getElementById("countdown_wrapper").style.background = '#04839B';
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

    $(function() {
      $(".sub_button").click(function() {
        if ($('#answer_area').val() != '') {
          var user_id = document.getElementById("user").innerHTML;
          var answer=$('#answer_area').val();
          var data = {
            "body": first + " * " + second,
            "answer": answer
          };
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
            if (response.statusText === 'correct') {
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
							var totals = (parseInt(document.getElementById("countdown").innerHTML));
							totals = totals += 1;
							document.getElementById("countdown").innerHTML = totals;
							first = document.getElementById("first_num").innerHTML = Math.floor((Math.random() * 10) + 1);
	            second = document.getElementById("second_num").innerHTML = Math.floor((Math.random() * 10) + 1);
							seconds = 3
            } else {
							first = document.getElementById("first_num").innerHTML = "-";
							second = document.getElementById("second_num").innerHTML = "-";
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
          },
          error: function(response) {
            console.log(response)
          }
        });
        $("#answer_area").val('');
				return false;
      });
    });

  };
});
