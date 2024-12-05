---
title: Page Speed
draft: false
date: 2024-12-05
extra:
  icon: 🏎️
  center: true
description: Check loading of site with PageInsight API
---


<input placeholder="Enter site to test..." id=input placeholder="maxbruges.pages.dev" value="maxbruges.pages.dev" type=text><button id=roll>Check</button>

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
      console.log(lighthouse)
      const lighthouseMetrics = {
        'Performance Score': lighthouse.categories.performance['score'] ? (lighthouse.categories.performance['score'] * 100).toFixed(0) + '%' : 'N/A',
        'First Contentful Paint': lighthouse.audits['first-contentful-paint'] ? lighthouse.audits['first-contentful-paint'].displayValue : 'N/A',
        'Speed Index': lighthouse.audits['speed-index'] ? lighthouse.audits['speed-index'].displayValue : 'N/A',
        'Time To Interactive': lighthouse.audits['interactive'] ? lighthouse.audits['interactive'].displayValue : 'N/A'
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
  const lighthouseHeader = document.createElement('h2');
  lighthouseHeader.textContent = "Lighthouse Results";
  contentDiv.appendChild(lighthouseHeader);
  for (key in lighthouseMetrics) {
    const p = document.createElement('p');
    p.textContent = `${key}: ${lighthouseMetrics[key]}`;
    contentDiv.appendChild(p);
  }
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
