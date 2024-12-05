---
title: Fortune Cookie
description: Seek cryptic wisdom from the digital sage.
extra:
  icon: 🥠
  center: true
date: 2024-12-03
---


<button id=roll class=center>Read my fortune</button>

<blockquote id=output></blockquote>

<script>
document.getElementById('roll').addEventListener('click', function() {
    const output = document.getElementById('output');
    output.innerHTML = '<span class="load">🥠</span>';

    fetch('https://api.mxb.fyi/fortune')
      .then(response => {
          if (response.status === 429) {
              output.innerText = 'Too many requests! Wait a minute.'; // Update output for 429 status
              return; // Do nothing if response is 429
          }
          return response.text();
      })
      .then(result => {
          output.innerText = ` ${result}`;
      })
      .catch(error => {
          output.innerText = 'Error: ' + error.message;
      });
});
</script>
