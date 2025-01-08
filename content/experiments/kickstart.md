---
title: Kickstart
description: "Struggling to begin an answer? Generate sentence starters to get going."
date: 2025-01-08
extra:
  icon: 🛵
  center: true
---

<input type=text id="question-input" placeholder="Enter the question..." style="min-width:80%;text-align:center">
<br>
<button type="button" id="button" onclick="sendToAPI(event)" style="min-width:7em">Kickstart!</button><p id=loader>⏳</p>

<div id=card-container></div>

<style>

#loader {
    display: none;
    animation: rotate 1s linear infinite;
}

@keyframes rotate {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
}

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

<script>
function sendToAPI(event) {
  if (event) event.preventDefault(); 
  const input = document.getElementById('question-input');
  const button = document.getElementById('button');
  const container = document.getElementById('card-container')
  const loader = document.getElementById('loader')
  container.innerHTML = ""
  button.style.display = "none";
  loader.style.display = "block";
  input.disabled = true;
  button.disabled = true;
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
      }).catch(error => console.error('Error:', error))
      .finally(() => {
          input.disabled = false;
          button.disabled = false;
          button.style.display = "initial";
          loader.style.display = "none";
          button.innerText = "Kickstart!";
      });
}, 10);
}
</script>
