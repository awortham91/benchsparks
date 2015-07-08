document.getElementById("counter").onclick = function() {countdown()};

function countdown() {
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
        }
    }
    tick();

}
