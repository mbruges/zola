---
title: Renewing the digital library
date: 2026-04-14
authors: ["Max Bruges"]
description: "Bringing books to readers, wherever they are"
draft: false
extra:
  icon: 📚
---

![The magnificent library of Trinity Dublin, on a laptop screen](/images/laptop-library.webp)
*The road to Kells is paved with good intentions.*

Way back in the dark times of Covid, I set up a [little digital library](https://drive.google.com/drive/folders/1bfdVXfVdFbaWnvR3IHbcQ6NITxLBEDaO?usp=drive_link) for my absent students. It was simple as could be: a link to a shared Google Drive, populated with `.epub` files. Readers could quickly scroll through, find a book, and download straight to their device. It wasn't perfect, but it did serve its purpose.

Now, with the [return to distance learning](https://gulfnews.com/uae/education/dubais-khda-issues-distance-learning-guidelines-asks-schools-to-review-system-in-two-weeks-1.500494168), it seemed as good a time as any to build a more tailored solution.

Say hello to *[books.brug.es](https://books.brug.es/)*.

## New and improved

Digital Library 2.0 needed two features:
1) A search function
2) The ability to read the book _straight away,_ in the browser

Even the slightest friction is enough to put off the reluctant reader, so a point-and-shoot solution was essential, without the rigmarole of downloading an `.epub`, finding a suitable reader app, setting the reader _etc_.

There are [lots](https://github.com/herraristotle/BookLore) [of](https://github.com/bookstairs/bookstairs) [projects](https://www.kavitareader.com/) out there for hosting one's digital book collection, though all a little heavy for my liking. I've no need to track reading progress, register users, accept content submissions or the like. I even went so far as coding up a basic gallery of books - `HTMX` on the front-end, `Flask` on the back-end - before eventually stumbling on the perfect solution.

## Checking out, tidying up

[BookBrowser](https://github.com/pgaskin/BookBrowser) is, sadly, abandoned, but by all my metrics it's feature complete. Even better, it runs as a single Go binary, watching a flat directory of `.epub` files and serving up a super-simple library page, as well as a perfectly adequate in-browser eReader. 

![aside](/images/books-bruges.webp)

I forked it, splashed some _Mr. Bruges_ branding, then tweaked a few options to streamline the experience. The end result is the Platonic ideal of the Digital Library.

It quietly ticks over in a container on my little server, accessible via a Cloudflare tunnel, and accessible to all at [books.brug.es](https://books.brug.es).

And by week four of our latest stint of remote learning, it has plenty of satisified customers.
