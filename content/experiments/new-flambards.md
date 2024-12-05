---
title: Flambards Fly Again
description: Generate infinite [Flambards](https://global.oup.com/education/content/children/series/flambards/?region=international) melodrama through the power of AI.
date: 2024-12-05
extra:
  icon: 🐎
  center: true
---

<input type=text id=promptInput placeholder='A tragic story of...'><button id=submit>Generate a Flambard</button>

<style>
.slider-holder {
    flex: 1 1 10%;
    padding: 0.2em;
    text-align: center;
    background:rgb(0,0,0,0.2);
    border-radius:var(--border-radius)
}
h4 {
    padding:0.1em;
}
</style>

<div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 10px;">


<div class=slider-holder>
    <label for="tragicSlider"><h4>Tragedy</h4></label>
    <input type="range" id="tragicSlider" value="10" min="0" max="100" step="10">
</div>

<div class=slider-holder>
    <label for="rusticSlider"><h4>Rustication</h4></label>
    <input type="range" id="rusticSlider" value="10" min="0" max="100" step="10">
</div>

<div class=slider-holder>
    <label for="romanceSlider"><h4>Romance</h4></label>
    <input type="range" id="romanceSlider" value="10" min="0" max="100" step="10">
</div>

<div class=slider-holder>
    <label for="aeroSlider"><h4>Aeronautics</h4></label>
    <input type="range" id="aeroSlider" value="10" min="0" max="100" step="10">
</div>
</div>


<blockquote id=output style="visibility:hidden;text-align:left;text-align: justify;">
</blockquote>

<script>
function FlambardsGenerator() {
        console.log("running generator")

        var imageURL = "https://mbruges.com/images/biplane.svg"
        var newresponse = "Something went wrong."
        var prompt = `You are the novelist K. M. Peyton, author of the 'Flambards' series. You will write in her style. Respond in plain text. \nUsing everything you know about the 'Flambards' series of books, write a 200-word, two paragraph short story about the characters. You must split your two paragraphs with two <br> tags`

        //Adding on any specifics that the user requests
        var additions = document.getElementById("promptInput").value;
        if (additions.length > 3) {
        additions = "\nIn your story, include: " + additions;
        prompt += additions}

        var tragic = document.getElementById("tragicSlider").value;
        var rustic = document.getElementById("rusticSlider").value;
        var romance = document.getElementById("romanceSlider").value;
        var aero = document.getElementById("aeroSlider").value;

        prompt += `Make the story ${tragic}% tragic, ${rustic}% rustic, ${romance}% romantic, and ${aero}% about aeroplanes.`

        document.getElementById("output").innerHTML = `<center><br>Writing the next chapter...<br><span class=load>❊</span>`;
        document.getElementById("output").style.visibility = ''
        url_escaped_prompt = encodeURIComponent(prompt);

        fetch(`https://api.mxb.fyi/gpt-mini?query=${url_escaped_prompt}`)
          .then(response => {
            if (response.status === 429) {
              throw new Error('Too many requests! Wait a minute.');
            }
            return response.text();
          })
          .then(result => {
              newresponse  = ` ${result}`;
            newresponse =
            `<h2 style="text-align:center !important"><i>Chapter 94:</i>
            <br>Flambards Forever</h2>
            <br>
            <p style="width:88%;margin-left:auto;margin-right:auto;">${newresponse}</p>`;
            document.getElementById("output").innerHTML = newresponse;

          })
          .catch(error => {
                let errormessage = `<center><h1>Tragedy strikes</h1><br><p>Something has gone terribly wrong with the app. Give it a few minutes and try again.</p> <br>  <img style="border-color: black
            ;border: 3px;border-style:solid;"  alt="illustrationGenerated" src="/images/biplanefire.png"height="150px" width="150px"><details><summary style="font-size:11px">Error message:</summary><code style="font-size:11px"> ${error}</code></details></center> `;
            document.getElementById("output").innerHTML = errormessage;
            });
        }

document.getElementById("submit").addEventListener("click", FlambardsGenerator);
</script>
