---
title: Roll the Dice
description: Are you feeling lucky?
extra:
  icon: 🎲
date: 2024-12-03
---

<div class=center>

<button id=roll class=center>ROLL</button>

You rolled a:

<code id=output></code>

</div>

<script>
document.getElementById('roll').addEventListener('click', function() {
    fetch('https://flask.mxb.fyi/dice')
      .then(response => {
          if (response.status === 429) {
              return 'Too many rolls! Wait a minute.'; // Do nothing if response is 429
          }
          return response.text();
      })
      .then(result => {
          document.getElementById('output').innerText = ` ${result}`;
      })
      .catch(error => {
          document.getElementById('output').innerText = 'Error: ' + error.message;
      });
});
</script>
