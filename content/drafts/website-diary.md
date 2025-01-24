---
title: Note to self
draft: true
date: 2024-12-10
description: "A working log of what I've done to build this site"
extra:
  icon: 🏗️
---

## *15/01/25* - Annotations and aggravations

Trying to implement live/accessible annotations to the textbook pages; quixotically it seems.

Settled on the Hypothes.is service - achieves the functionality I want, but is quite heavy (1MB js) and reliant on an external database. Can potential self-host, but that's an adventure for a later date.

Adding the raw Hypothesis system was very easy, a single JS script. What I wanted, though was to just pull annotations from the API and display them in my own nice formatting, without the heavy sidebar etc. THAT has been an exercise in madness. 

The difficulty, simply put, is working out _where_ to put an annotation on a page. The API provides a `start index`, but my extensive fiddling seems to indicate no relationship between this number and the page's raw text or its HTML (when using `indexOf()`)

Have just seen one can put the sidebar into a specific container. Shall try that...

_Some time later_

Got it! After going on a crash course in XPath selection with GPT, managed to build a decent-enough selector based on the path provided in the API. This was the key to finally ditch the massively chunky Hypothesis panel: I can now pull highlights AND place them on the page using only the API endpoint. Fanastic!

Compare and contrast:

| | Old method | New method |
| ---: | :---: | :---: |
| Size | 1,300kb | 28kb |
| Loading | 6000 ms | 37ms |
| Rendering | 7300 ms | 800ms |
| External calls | 24 | 1 |
| Satisfaction | Begrudging | *Immeasurable* |

The script and the accompanying CSS are now tied up in an HTML snippet, added to those pages that could benefit from annotation (just textbook pages for now).

To add annotations, I (and future approved users!) can use the very nifty [Hypothesis browser extension](https://web.hypothes.is/start/#:~:text=to%20your%20browser.-,install%20the%20hypothesis,-Chrome%20extension%20from).

Next step is self-hosting my own Hypothesis instance, but that can wait.

---

## *22/12/24* - Adventures in dithering and webpeeing

Had a fiddle about trying to cut down image sizes, _stylistically_. [Read that article](https://endtimes.dev/why-you-should-dither-images/) about dithering and gave it a go.

Reasonably good script cobbled together using image magick to convert images into 1bit dithered versions, with `--b` and `--t` as the two colours. Resized, compressed a little, spat out into a `.png`, and... the resulting file was ten times the size of the `.webp` original. Hmm.

![a dithered image of a pen nib](/output.png)
*Pretty, but not `37 kilobytes`-worth of pretty.*

Tweaked the script a little more after some StackOverflowing - apparently *Ordered* dithering can be compressed more efficiently, etc. Yet even with this, *and* converting the end result to `.webp`, the monochromatic version was regularly 30-50% *larger* than the normal version. Bizarre.

Perhaps there exists a special compression incantation of Image Magick that shrinks 1bit images down to nothing, but I've not found it. Til then, I'll stick with `.webp` ([which I probably should have done in the first place](https://www.simplethread.com/why-your-website-should-not-use-dithered-images/)).

In that spirit: have added a `git hook` script to automatically convert all images added to `static/images` to `.webp` format, 800px wide (as wide as they'll ever be on the site). In most cases, this manages to cut down the file size by 50-90%. These will never look good on a hoarding, but look *Good Enough* on a laptop or phone, for a fraction of the memory footprint.

---

## *11/12/24* - Fixing the Live Lesson Preview

- Homepage originally had a little `iframe`, showing the 'live lesson' (ie [learn.maxbruges.com](learn.maxbruges.com))
- Nice, easy to implement, and showed exactly what was on show
- Had to make a websocket connection for it to work, but that was quite quick
- Main issue? No lazy loading in Marp!
- Every time that little window loaded, it would *also* download all the images in which ever lesson was on display at the time. Madness!
- All we need is a little preview screenshot. So that's what I implemented...

### Making a preview snapshot

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

Overall: cut down multi-megabyte background loading of the Live Preview to just 5kb, enough for the low res `livecap.webp`. And without a websocket connection to make, it's even faster and more compatible with dodgy networks and older browsers.

Very satisfying.

---

## *01/12/24* - Moving to Zola
