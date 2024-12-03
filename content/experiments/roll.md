---
title: Roll the Dice
description: Are you feeling lucky?
extra:
  icon: 🎲
  center: true
date: 2024-12-03
---

<button id=roll >ROLL</button>

You rolled a:

<code id=output></code>

<script>
document.getElementById('roll').addEventListener('click', function() {
  const output =  document.getElementById('output')
    output.innerHTML = '<span class="load">🎲</span>';
    fetch('https://flask.mxb.fyi/dice')
      .then(response => {
          if (response.status === 429) {
              return 'Too many rolls! Wait a minute.'; // Do nothing if response is 429
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
