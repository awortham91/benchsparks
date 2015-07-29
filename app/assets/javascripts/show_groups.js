
    function show(n) {
      elements = document.getElementsByClassName('disappear');
      for (var i = 0; i < elements.length; i++) {
        document.getElementById(elements[i].id).style.display = 'none';
      };
      $.ajax({
        type: "GET",
        url:  "/groups/" + n,
        success: function(response) {
          document.getElementById("name").innerHTML = response.name;
          var students = ''
          response.users.forEach(function(student) {
            students = students + student + "<br>"
          });
          document.getElementById("students").innerHTML = students
          document.getElementById(n).style.display = 'block';
        },
        error: function(response) {

          console.log(response);
        }
      });
    };
