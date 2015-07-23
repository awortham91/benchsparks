function show(n) {
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
    },
    error: function(response) {

      console.log(response);
    }
  });
};
