---
title: Search
description: Dig through the posts and resources of this site, using [elasticlunr.js](http://elasticlunr.com/).
extra:
  icon: 🔎
  center: true
  nosub: true
date: 2025-01-01
---

<link rel="stylesheet" href="/blog-index.css">

<script src="/elasticlunr.min.js"></script>
<script src="/search_index.en.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const idx = elasticlunr.Index.load(window.searchIndex);
        const searchIcon = document.getElementById('search')
        document.getElementById('post-nav').style.display = "none"
        document.getElementById('footer-bar').style.display = "none"
        document.getElementById('footer').style.position = "absolute"
        document.getElementById('footer').style.bottom = "2em"
        document.getElementById('footer').style.left = "0%"
        prevPage = document.referrer ? document.referrer.split('/').pop() : "";
        searchIcon.innerHTML = `<a id="back" href="javascript:history.back()" alt="Back to ${prevPage}" title="Back to ${prevPage}">↩</a>`;
        document.getElementById('date-tag').style.visibility = "hidden"

        document.getElementById('search-input').addEventListener('input', function() {
            const query = this.value;
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

            results.forEach(result => {
                const item = idx.documentStore.getDoc(result.ref);
                const element = document.createElement('div');
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
                        section += " 👓";
                        break;
                }
                element.innerHTML = `
                  <div class="blog-card flex" style="text-align:left" onclick="location.href='${item.id}';" onmouseenter=""><div class="blog-details"><p> <span class="title">${item.title}  </span><span style="font-family:monospace;background:var(--a);color:var(--b);font-size:0.8em;border-radius:0.2em;padding:0.3em">${section}</span><br></p><div class="description"><p class="truncate" style="-webkit-line-clamp: 1;"><b> ${item.description} </b> ${item.body.slice(0,300)} <span class="read-on-container" style="padding-left:2em;"><i class="read-on">click to read ⇝</i></span></p></div></div></div>`;
                resultsDiv.appendChild(element);
            });
        });
    });
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
            <input class="form-control" type="search" id="search-input" name="search" placeholder="Search posts..." autofocus>
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
                        border-radius: 4px;
                    }
                </style>
            </div>
        </div>
