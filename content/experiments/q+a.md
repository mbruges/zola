---
title: AutoQuiz
description: "Prototype: OpenAI as a quiz master"
date: 2025-03-07
draft: true
extra:
  icon: 💯
  center: true
---

Test your Macbeth knowledge, with `OpenAI` as the judge of how right your answer is.

<blockquote id="question">
    Thinking up a question...
</blockquote>


<input id=answer type=text placeholder="Type your answer..." />
<button id=submitAnswer>Submit answer</button>


<p id=response></p>

<br>
    <script>
      fetch('/files/questions.json')
        .then(response => response.json())
        .then(data => {
          const randomQuestion = data[Math.floor(Math.random() * data.length)];
          const answers = randomQuestion.a
          window.answers = answers
          document.getElementById('question').innerText = randomQuestion.q;
        })
        .catch(error => console.error('Error loading questions:', error));
    </script>
 
 <script>
   document.addEventListener('DOMContentLoaded', function() {
     document.getElementById('submitAnswer').addEventListener('click', function() {
       const userAnswer = document.getElementById('answer').value;
       const questionText = document.getElementById('question').innerText;
 
       let fullRequest = `You are a helpful pop-quiz grader. Evaluate the user's response to this question, responding with either CORRECT or INCORRECT, followed by a very brief explanation addressed to the user (do not comment on style or formatting).\nQUESTION: ${questionText}\nPOTENTIAL CORRECT ANSWERS INCLUDE:${answers}\nUSER ANSWER:${userAnswer}`;
 
       fetch(`https://api.mxb.fyi/gpt-mini?query=${encodeURIComponent(fullRequest)}`)
         .then(response => response.text())
         .then(data => {
           document.getElementById('response').innerText = data;
         })
         .catch(error => console.error('Error submitting answer:', error));
     });
   });
  </script>
