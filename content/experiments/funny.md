---
title: Funny Bot
description: Ask the bot for some jokes
extra:
  icon: 😂
  center: true
date: 2024-12-03
---


<button id=roll class=center>Tell me a joke</button>

<blockquote id=output></blockquote>

<script>
document.getElementById('roll').addEventListener('click', function() {
    const output = document.getElementById('output');
    output.innerHTML = '<span class="load">😂</span>'; // Show loading symbol

    fetch('https://api.mxb.fyi/jokes')
      .then(response => {
          if (response.status === 429) {
              output.innerText = 'Too many requests! Wait a minute.'; // Update output for 429 status
              return; // Do nothing if response is 429
          }
          return response.text();
      })
      .then(result => {
          output.innerText = ` ${result}`; // Display the joke
      })
      .catch(error => {
          output.innerText = 'Error: ' + error.message; // Display error message
      });
});
</script>
