---
title: Search
description: Dig through the posts and resources of this site, using [elasticlunr.js](http://elasticlunr.com/).
template: "search.html"
extra:
  icon: 🔎
  center: true
  nosub: true
date: 2025-01-01
---
<div id=loader>
    <p><i>Loading search...</i><p>
<svg fill='none' height='24' width='24' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'><style> g { animation: rotate 2s linear infinite; transform-origin: center center; } circle { stroke-dasharray: 75,100; stroke-dashoffset: 0; animation: dash 1.5s ease-in-out infinite; stroke-linecap: round; } @keyframes rotate { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } } @keyframes dash { 0% { stroke-dasharray: 1,100; stroke-dashoffset: 0; } 50% { stroke-dasharray: 44.5,100; stroke-dashoffset: -17.5; } 100% { stroke-dasharray: 44.5,100; stroke-dashoffset: -62; } } </style><g><circle cx='12' cy='12' r='10' fill='none' stroke='rgb(136, 145, 164)' stroke-width='4' /></g></svg>
</div>

<link rel="stylesheet" href="/blog-index.css">

<script src="/elasticlunr.min.js"></script>
<script src="/search_index.en.js"></script>
<script>
function makeSearch(element) {
      var idx = elasticlunr.Index.load(window.searchIndex);
      const query = element.value;
      const results = idx.search(query, {
          fields: {
              title: {boost: 2},
              description: {boost: 2},
              body: {boost: 1},
          },
          expand: true,
      });

      const resultsDiv = document.getElementById('search-results');
      resultsDiv.innerHTML = '';
      index = 1
      results.forEach(result => {
          const item = idx.documentStore.getDoc(result.ref);
          const element = document.createElement('div');
          element.tabIndex = index + 3;
          element.className = 'blog-card flex';
          element.style.textAlign = 'left';
          element.onclick = () => location.href = item.id;
          let section = item.path.substring(item.path.indexOf('/') + 1, item.path.indexOf('/', item.path.indexOf('/') + 1));
          switch (section) {
              case 'experiments':
                  section += " 🧪";
                  break;
              case 'blog':
              section += " 🗞️";
                  break;
              case 'learn':
              section += " 👨‍🏫";
                  break;
              default:
                  section += " 🔎";
                  break;
          }
          element.innerHTML = `
            <div class="blog-details"><p> <span class="title">${item.title}  </span><span style="font-family:monospace;background:var(--a);color:var(--b);font-size:0.8em;border-radius:0em;padding:0.3em">${section}</span><br></p><div class="description"><p class="truncate" style="-webkit-line-clamp: 1;"><b> ${item.description} </b> ${item.body.slice(0,300)} <span class="read-on-container" style="padding-left:2em;"><i class="read-on">click to read ⇝</i></span></p></div></div>`;
          resultsDiv.appendChild(element);
          index++
      });
}
    document.addEventListener('DOMContentLoaded', function() {
        
        // const searchIcon = document.getElementById('search')
        // searchIcon.innerHTML = `<a id="back" href="javascript:history.back()" alt="Back to ${prevPage}" title="Back to ${prevPage}">↩</a>`;

        document.getElementById('footer').style.position = "absolute"
        document.getElementById('footer').style.bottom = "1em"
        document.getElementById('footer').style.left = "0%"
        document.getElementById('loader').style.display = "none"
        prevPage = document.referrer ? document.referrer.split('/').pop() : "";
        var searchInput = document.getElementById('page-search-input')
        searchInput.addEventListener('input', function() {
            makeSearch(searchInput);
        });
        console.log("looking for query")
        const urlParams = new URLSearchParams(window.location.search);
        const query = urlParams.get('q');
        if (query) {
          console.log("running search with query")
            searchInput.value = decodeURIComponent(query);
            searchInput.dispatchEvent(new Event('input'));
        }
      })
        
    
</script>

<style>
.search-results {
--mask: linear-gradient(to bottom, 
      rgba(0,0,0, 0) 0,   rgba(0,0,0, 1) 7%,   rgba(0,0,0, 1) 80%, 
      rgba(0,0,0, 0) 95%, rgba(0,0,0, 0) 0
  ) 100% 50% / 100% 100% repeat-x;
  mask: var(--mask);
}


</style>

<div class="searchContainer">
            <input class="form-control" type="search" id="page-search-input" name="search" placeholder="Search posts..." autofocus>
            <div id="search-results" class="search-results" style="max-height:57vh;min-height:57vh;overflow-y:scroll; scrollbar-color: var(--a) var(--b); position: relative;padding-bottom:6em;padding-top:2em;">
                <style>
                    .search-results::-webkit-scrollbar {
                        width: 8px;
                    }
                    .search-results::-webkit-scrollbar-track {
                        background: var(--b);
                    }
                    .search-results::-webkit-scrollbar-thumb {
                        background: var(--a);
                        border-radius: 0px;
                    }
                </style>
            </div>
        </div>
