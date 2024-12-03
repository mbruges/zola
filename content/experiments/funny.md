---
title: Funny Bot
description: Ask the bot for some jokes
extra:
  icon: 🤣
date: 2024-12-03
---

<div class=center>

<button id=roll class=center>Tell me a joke</button>

<blockquote id=output></blockquote>

</div>

<script>
document.getElementById('roll').addEventListener('click', function() {
    fetch('https://flask.mxb.fyi/jokes')
      .then(response => {
          if (response.status === 429) {
              return 'Too many requests! Wait a minute.'; // Do nothing if response is 429
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
