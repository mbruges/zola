---
title: Where are Max and Catherine?
description: ""
draft: true
extra:
  icon: ✈️
date: 2024-12-14
---
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<script>
window.onload = () => {
  setTimeout(function(){
    location.reload();
  }, 300000);}
</script>

<script>
  var countDownDate = new Date();
  if (countDownDate.getUTCHours() >= 13 && countDownDate.getUTCMinutes() > 40 || countDownDate.getUTCHours() > 13) {
    countDownDate.setDate(countDownDate.getDate() + 1);
  }
  countDownDate.setUTCHours(13);
  countDownDate.setUTCMinutes(40);
  countDownDate.setUTCSeconds(0);
  var x = setInterval(function() {
    var now = new Date().getTime();
    var timeLeft = countDownDate - now;
    var hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
    if (timeLeft < 0) {
      clearInterval(x);
      document.getElementById("countdown").innerHTML = "...any minute now!";
    } else {
      document.getElementById("countdown").innerHTML = "in " + hours + "h " + minutes + "m " + seconds + "s";
    }
  }, 1000);
</script>

<h3 class=center>
  Scheduled to land: <span id=countdown></span>
</h3>

<img class=center src="https://mxb.fyi/static/flight-screenshot.webp" width=400 height=800 style="min-height:500px">
