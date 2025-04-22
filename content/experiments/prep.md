---
title: PREP your prompt!
description: "Using the [PREP model](https://digitallearning.cognita.com/before-teaching/before-teaching-initial-contextual-content-planning/) to craft the perfect prompt"
date: 2025-04-22
draft: false
extra:
  icon: 🎨
  buttontext:
  link:
  center: true
---

<style>

select,input {
    text-align:center;
    border:none;
    font-size: 1em;
    font-style:inherit;
    background:none !important;
    -webkit-appearance: none;
      -moz-appearance: none;
      appearance: none;
      background: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' fill='%238C98F2'><polygon points='0,0 100,0 50,50'/></svg>") no-repeat;
      background-size: 12px;
      background-position: calc(100% - 20px) center;
      background-repeat: no-repeat;
      background-color: #efefef;
    border-bottom: 2px solid black;
    border-radius: 0px;
    padding:0.2em;
}

textarea {
    background: none;
    border-radius: 0px;
    font-family:inherit;
}

option:disabled {
    color: gray;
    background-color: #efefef; /* Same background color as the select */
    cursor: not-allowed; /* Change cursor to indicate the option is not selectable */
}

</style>


<p> I’m <select id=role required>
    <option value="" disabled selected>?</option>
    <option value="an Early Years">an Early Years</option>
    <option value="a Primary">a Primary</option>
    <option value="a Secondary">a Secondary</option>
</select> teacher in the <select id=curriculum>
    <option value="" disabled selected>?</option>
    <option value="British">British</option>
    <option value="American">American</option>
    <option value="IB / MYP">IB / MYP</option>
</select> curriculum, teaching about <input placeholder="Your topic" id=topic>.</p>

Help me generate <input id="object" placeholder="lesson plans, homework, schemes of work...">. 

Please also bear in mind...

<textarea placeholder="Any other requirements?"></textarea>

<button id=button>Create Prompt</button>

<blockquote id=result>

</blockquote>
<button id="gogpt" style="visibility:hidden;">Start chatting ↗</button>

<br>

<script>
    document.getElementById('gogpt').onclick = function() {
        const resultText = document.getElementById('result').innerText;
        navigator.clipboard.writeText(resultText).then(function() {
          const encodedText = encodeURIComponent(resultText);
          window.open(`https://claude.ai/new?q=${encodedText}`, '_blank');
        }, function(err) {
            console.error('Could not copy text: ', err);
        });
    };
</script>

<script>

document.getElementById('button').addEventListener('click', function() {
    const topic = document.getElementById('topic').value;
    const role = document.getElementById('role').value;
    const curriculum = document.getElementById('curriculum').value;
    const object = document.getElementById('object').value;
    const additionalNotes = document.querySelector('textarea').value;
    var resultBlock = document.getElementById('result');

    if (role && curriculum && topic) {
        var prompt = `I am ${role} teacher in the ${curriculum} curriculum, teaching about ${topic}. You are an expert teaching assistant, specialising in the teaching of ${topic}. Please provide me with ${object} on the topic of ${topic}, suitable for students in ${role} studying the ${curriculum}.
          `;
        if (additionalNotes) {
            prompt += ` Also, please consider: ${additionalNotes}.`;
        }
        resultBlock.innerText = prompt + ` Please suggest suitable materials and activities for ${topic}.`;
        document.getElementById('button').innerText = 'Make new prompt'
        document.getElementById('gogpt').style.visibility = 'visible';
        
    } else {
        resultBlock.innerText = 'Please fill in all fields.';
    }
});

</script>
