---
title: One-Shot
description: Send a single query to GPT 4o-mini. No API required - mostly an exercise in testing out `Flask` forwarding.
extra:
  icon: 🤖
  center: true
date: 2024-12-03
---

<input placeholder="Ask a question..." id=input type=text-area></input> <button id=roll class=center>Ask</button>

<blockquote style="visibility:hidden;max-width:50ch" id=output></blockquote>

<script>
document.getElementById('roll').addEventListener('click', function() {
    const output = document.getElementById('output');
    output.style.visibility = ""
    output.innerHTML = '<span class="load">🤖</span>';
    query = document.getElementById('input');
    fetch(`https://api.mxb.fyi/gpt-mini?query=${query.value}`)
      .then(response => {
        if (response.status === 429) {
          output.innerText = 'Too many requests! Wait a minute.';
          throw new Error('Too many requests! Wait a minute.');
        }
        return response.text();
      })
      .then(result => {
          output.innerText = ` ${result}`;
      })
      .catch(error => {
          output.innerText = 'Error: ' + error.message; message
      });
});
</script>

<br>
