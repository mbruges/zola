---
title: Search
description: Dig through the posts and resources of this site, using [elasticlunr.js](http://elasticlunr.com/).
extra:
  icon: 🔎
  center: true
date: 2025-01-01
---

<link rel="stylesheet" href="/blog-index.css">

<script src="/elasticlunr.min.js"></script>
<script src="/search_index.en.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const idx = elasticlunr.Index.load(window.searchIndex);
        const searchIcon = document.getElementById('search')
        searchIcon.innerHTML = `<a id="back" href="javascript:history.back()">↩</a>`;
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

                const section = item.path.substring(item.path.indexOf('/') + 1, item.path.indexOf('/', item.path.indexOf('/') + 1));
                element.innerHTML = `
                  <div class="blog-card flex" style="text-align:left" onclick="location.href='${item.id}';" onmouseenter=""><div class="blog-details"><p> <span class="title">${item.title}  </span><span style="font-family:monospace;background:var(--a);color:var(--b);font-size:0.8em;border-radius:0.2em;padding:0.3em">${section}</span><br></p><div class="description"><p class="truncate" style="-webkit-line-clamp: 1;"><b> ${item.description}</b>${item.body.slice(0,300)} <span class="read-on-container"><i class="read-on">click to read ⇝</i></span></p></div></div></div>`;
                resultsDiv.appendChild(element);
            });
        });
    });
</script>

<div class="searchContainer">
            <input class="form-control" type="search" id="search-input" name="search" placeholder="Search posts..." autofocus>
            <div id="search-results" class="search-results" style="max-height:50vh;min-height:50vh;overflow-y:scroll; scrollbar-color: var(--a) var(--b);">
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
