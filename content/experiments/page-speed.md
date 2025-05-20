---
title: PageSpeed
draft: true
date: 2024-11-05
extra:
  icon: 🏎️
  center: true
description: Check the loading speed of any site with Google's PageSpeed Insights API.
---


<input placeholder="Enter site to test..." id=input placeholder="maxbruges.com" type=text><button id=roll>Check</button>

<blockquote style="visibility:hidden;max-width:50ch" id=output></blockquote>

<script>
const contentDiv = document.getElementById('output')

function run() {
  const url = setUpQuery(document.getElementById('input').value);
  fetch(url)
    .then(response => response.json())
    .then(json => {
      // See https://developers.google.com/speed/docs/insights/v5/reference/pagespeedapi/runpagespeed#response
      // to learn more about each of the properties in the response object.
      console.log(json)
      //showInitialContent(json.id);

      // const cruxMetrics = {
      //   "First Contentful Paint": json.loadingExperience.metrics.FIRST_CONTENTFUL_PAINT_MS.category,
      //   "First Input Delay": json.loadingExperience.metrics.FIRST_INPUT_DELAY_MS.category
      // };
      // showCruxContent(cruxMetrics);
      const lighthouse = json.lighthouseResult;
      const lighthouseMetrics = {
        'Performance Score': lighthouse.categories.performance['score'] ? (lighthouse.categories.performance['score'] * 100).toFixed(0) + '%' : 'N/A',
        'First Contentful Paint (<2s)': lighthouse.audits['first-contentful-paint'] ? lighthouse.audits['first-contentful-paint'].displayValue : 'N/A',
        'Speed Index (<3.4s)': lighthouse.audits['speed-index'] ? lighthouse.audits['speed-index'].displayValue : 'N/A'
      };
      showLighthouseContent(lighthouseMetrics);
    });
}

function setUpQuery(urlToTest) {
  const api = `https://www.googleapis.com/pagespeedonline/v5/runPagespeed`;
  const parameters = {
    url: encodeURIComponent(urlToTest)
  };
  let query = `${api}?`;
  for (key in parameters) {
    query += `${key}=https://${parameters[key]}/`;
  }
  return query;
}


function showInitialContent(id) {
  contentDiv.innerHTML = '';
  const title = document.createElement('h1');
  title.textContent = 'PageSpeed Insights API Demo';
  contentDiv.appendChild(title);
  const page = document.createElement('p');
  page.textContent = `Page tested: ${id}`;
  contentDiv.appendChild(page);
}

function showCruxContent(cruxMetrics) {
  const cruxHeader = document.createElement('h2');
  cruxHeader.textContent = "Chrome User Experience Report Results";
 contentDiv.appendChild(cruxHeader);
  for (key in cruxMetrics) {
    const p = document.createElement('p');
    p.textContent = `${key}: ${cruxMetrics[key]}`;
    contentDiv.appendChild(p);
  }
}

function showLighthouseContent(lighthouseMetrics) {
  const lighthouseHeader = document.createElement('h3');
  lighthouseHeader.innerHTML = "Results";
  contentDiv.appendChild(lighthouseHeader);
  for (key in lighthouseMetrics) {
    const p = document.createElement('p');
    p.textContent = `${key}: ${lighthouseMetrics[key]}`;
    contentDiv.appendChild(p);
  }
  const small = document.createElement('small');
  small.innerHTML = "<a href='https://developers.google.com/speed/docs/insights/v5/about'>Learn more</a>"
  contentDiv.appendChild(small);
  document.getElementById('load').style.visibility = 'hidden'
}

document.getElementById('roll').addEventListener('click', function() {
  const output = document.getElementById('output');
  output.style.visibility = "";
  output.innerHTML = '<span class="load" id="load">⏳</span>';
  query = document.getElementById('input');
  run();
})

</script>
