---
title: Website Diary
draft: true
date: 2024-12-10
description: "A working log of what I've done to build this site"
extra:
  icon: 🏗️
---

## Fixing the Live Lesson Preview - 11/12/24

- Homepage originally had a little `iframe`, showing the 'live lesson' (ie [learn.maxbruges.com](learn.maxbruges.com))
- Nice, easy to implement, and showed exactly what was on show
- Had to make a websocket connection for it to work, but that was quite quick
- Main issue? No lazy loading in Marp!
- Every time that little window loaded, it would *also* download all the images in which ever lesson was on display at the time. Madness!
- All we need is a little preview screenshot. So that's what I implemented...

1. Buggered about trying to find a way of headlessly capturing a webpage. Settled on neat little [Docker container](https://github.com/NeverMendel/chrome-headless-screenshots). Really well implemented, with options to cut the viewport down to thumbnail size and output straight to `.webp`
1. **When** to take the screenshot was another matter. Wrote a mucky bash script - with `websocat` to listen to the websocket - to then fire off a screenshot whenever it detected a change. Screenshot would then upload to the `mxb.fyi/static` folder, ready to be pulled down.
1. On the index page, rijigged the websocket listener to not open up an iframe, but instead display the screenshot as an `img`. All fine and dandy.
1. But then... why do we need a websocket at all? Either the screenshot is there or it isn't! Rewrote the screenshotting script to delete the screenshot when a lesson ends, then set about stripping out the websocket code
1. In its place, tried to set up a `fetch` request that would see if `livecap.webp` is available - if it is, then a lesson must be underway, so can display to "Join the lesson" button.
1. This... was trickier than expected. Unnecessarily so. Luckily simplified it even further: the `img` element has the path to the screenshot hardcoded into `src`, with an `onload` function ready to fire if it successfully finds it. Great!
1. Except: **caches**. The browser would helpfully pull out the old `livecap.webp` from the last time it loaded the page, regardless of whether it still existed on the server. To fix this: a hacky little bit of JS which whacks a time string on the end of the image `src` as a query - e.g. `static/livecap.webp?ver=1733903625194` - to force the browser to request the image again. Solved!
1. Now, back to that screenshotting script. It seemed silly to have a request go all the way round the houses - connecting to a websocket on the same machine - to see if a single string had changed. Could there be a better way?
1. Ended up rewriting my little [websocket-server](https://github.com/mbruges/go-projects/tree/main/websocket-server) Go binary to output received messages to a `lastmsg` textfile. *Minor* twiddling with Docker required to make this file accessible outside the countainer, but it worked!
1. Now, instead of connecting the websocket, the script simply watches `lastmsg`, and fires off a screenshot when a change is made.
1. Screenshot goes straight to the image server, homepage checks it, and all is well.

Overall: cut down multi-megabyte background loading of the Live Preview to just 5kb, enough for the low res `livecap.webp`. And without a websocket connection to make, it's even faster and more compatible with dodgy networks and old browsers.

Very satisfying.

---
