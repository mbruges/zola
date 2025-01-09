---
title: Kickstart
description: "Struggling to begin an answer? Generate sentence starters to get going."
date: 2025-01-08
extra:
  icon: 🛵
  center: true
---


<script type="module">
import {toast} from "/scripts.js";

const urlParams = new URLSearchParams(window.location.search);
const query = urlParams.get('q');
if (query) {
    document.getElementById('question-input').value = query;
}

function sendToAPI(event) {
  if (event) event.preventDefault(); 
  const input = document.getElementById('question-input');
  const button = document.getElementById('button');
  const container = document.getElementById('card-container')
  container.innerHTML = ""
  button.setAttribute('aria-busy', 'true');
  button.innerText = ""
  input.setAttribute('aria-busy', 'true');

  setTimeout(() => {
  fetch(`https://api.mxb.fyi/kickstart?query=${encodeURIComponent(input.value)}`)
      .then(response => response.json())
      .then(data => {
        data.response.forEach((answer, index) => {
          setTimeout(() => {
              var starterCard = document.createElement('div');
              starterCard.className = 'starter-card';
              starterCard.innerHTML = `<p>${answer}</p>`;
              container.appendChild(starterCard);
          }, index * 300);
        });
      }).catch(error => {
        toast("⚠ Connection error, try again in a minute")
      })
      .finally(() => {
        button.setAttribute('aria-busy', 'false');
        input.setAttribute('aria-busy', 'false');
        button.innerText = button.getAttribute('aria-label');
      });
}, 10);
}

document.getElementById('button').addEventListener('click', sendToAPI);
</script>

<input type=text id="question-input" placeholder="Enter the question..." style="min-width:80%;text-align:center">
<br>
<button aria-label="Kickstart!" aria-busy=false type="button" id="button" style="min-width:7em" >Kickstart!</button>

<div id=card-container style="min-height: 18em"></div>

<style>

.starter-card {
    background-color: var(--a);
    color:var(--b);
    border-radius: var(--border-radius);
    padding: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    max-width: 300px;
    margin: 10px auto;
    text-align: center;
    font-size: 16px;
    animation: fade-in-down 0.5s ease;
}

@keyframes fade-in-down {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

#question-input:disabled {
    background-color: #f0f0f0;
    color: #b0b0b0;
}

</style>
