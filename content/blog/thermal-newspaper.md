---
title: Printing a nano newspaper
description: "All the news that's fit to thermal print with GPT-4o-mini."
authors: ["Max Bruges"]
date: 2025-01-16
draft: false
extra:
  icon: 📰
---

Reading things on paper is [better for your brain](https://phys.org/news/2024-02-screens-paper-effective-absorb-retain.html), and I've got a thermal printer in a box gathering dust.

Rather than blearily scrolling through BBC News first thing, why not get the news from a miniature newspaper, freshly printed each morning?  It's not quite ["sky before screens"](https://www.cyclingweekly.com/news/sky-before-screens-has-made-me-a-better-cyclist-could-it-work-for-you), but *"paper before pixels"* has a ring to it.

![The finished product, a newspaper printed on thermal paper showing the date, weather and news headlines](/images/nano-paper.webp)

Here's a guide to make it work: we'll go through setting up the [printer](#heating-up-the-press), formatting the [text](#fun-with-formatting), and using AI to generate our s[ummarised headlines](#the-news-digested).

## Heating up the press

The first step is <sup>re-</sup>learning[^1] how to operate the printer itself. It's a fairly standard model from our friends at the great electronics bazaar of Shenzen; one of hundreds that can be found on Amazon or Ali Express. I *think* [this](https://amazon.com) is the model, but frankly they're so commoditised that these steps ought to work regardless.

Start by connecting the printer directly over USB.[^2] On Linux[^3] we can run this command to see if it shows up in USB directory...

```bash
$ ls /dev/usb
lp0
```

There it is! `/dev/usb/lp0` is the path to the printer. Printing something with it is surprisingly easy: we simply `echo` directly to that path:

```bash
echo "Hello world!" >> /dev/usb/lp0
```

If all is well, you'll hear a happy whirr and a single line will have been printed to the thermal paper. It's often worth printing a couple of blank lines to make it easier to take the paper out, which you can with `echo " "`.

## Fun with formatting

> [](aside-note) If you'd like to get more advanced, there are a few libraries out there for [php](https://github.com/mike42/escpos-php) and [python](https://github.com/jbittencourt/python-escpos).

Thermal printers can be controlled using a common language of `Escape` codes. They don't all have access to the same vocabulary of commands - the sort that allows for fancy formatting *etcetera* - but the basics are pretty consistent.

Our model here is particularly vocabulary-poor. By trial and error, I found it can only really manage two different fonts (one even less readable than the standard) and a double-size font good for headers. No matter - that should suffice for our needs.

To set a format, we enter the `ESC` character - `\x1B` - followed by a given number. To print in double-size, for instance, we include the designated `Escape` code (!1) in the `echo`:

```bash
ESC="\x1B" && echo "${ESC}!1 This is big ${ESC}@ and this is back to normal"
```

These codes are helpfully [documented here](https://mike42.me/blog/what-is-escpos-and-how-do-i-use-it) by Mike Billington, scavenged from poorly formatted Epson documentation. Mike's guides are extremely good, and the best place to look if you get stuck on anything ESC/POS.

The printer will do exactly - and *only* - what we explicitly tell it to. That means that niceties like word-wrapping need to be implemented manually, which I ended up doing through a `bash` function.  

Combine this with some basic `sed` and `grep`, and we've soon got a very rudimentary desktop publisher for our printer:  
- word-wrapped paragraphs
- double-size font for titles (indicated with a markdown-style `#`)
- a cut-off line at the end

Simply pipe in the text you want printed and out it will whirr. You can download my [full printing script here](/files/tprint.sh).

## Getting the content

In the spirit of analogue minimalism, we only want three things on our newspaper: the date, the weather and the news.

The date is easy, a quick `date +"# %a %d %h %y"`, with the octothorpe at the front letting the printing script know that this is the title.

The weather we can use the excellent [wttr.in](https://wttr.in) service:

```bash
$ curl 'wttr.in/Dubai?format="Dubai:+%f,+%C\n"' | sed 's/°//g'  
"Dubai: +25C, Clear"
```

This gives us a nice clean string with temperature and conditions. The little `sed` command is there to strip out the degree symbol, which Shenzen's finest helpfully renders as a random Chinese character.

## The news, digested

Getting the headlines is a trickier matter. We're going to use GPT-4o-mini to help condense down the news, but we've got to get the raw material in the first place. There's a bit of a vogue for minimalist, brutalist, text-only sites at the moment - call it the HackerNews effect - and I particularly like [neuters](https://neuters.de/). But for all their opinionated clarity, they're still *webpages*, and we want something purely textual.

Time to reach for old faithful: `RSS`. The Guardian (when they aren't [selling off](https://www.reuters.com/business/media-telecom/britains-guardian-group-agrees-sell-observer-newspaper-tortoise-media-2024-12-06/) beloved media brands) still runs an excellent RSS feed. Quick, free, and machine readable - ideal for our needs.

We start by parsing the XML data of the RSS feed, using the utl `xmllint`[^4]:

```bash
curl -s 'https://feeds.theguardian.com/theguardian/uk/rss' \
| xmllint --xpath '(//item/title|//item/description)[position() <= 16]' -  
```

This filters the feed so that it returns only the title and description for each news story. So we don't totally hammer our API (and credit card) when it comes to processing, I've limited the feed to only 16 items or stories. The Guardian occasionally includes some HTML in the descriptions, which we can strip out with:

```bash
sed 's/href=.*&gt;//g' | sed 's/&lt;//g' \
| sed 's/&gt;//g' | sed 's|<title>|\n<title>|g'  
```

We've now got a lovely, clean block of news to feed into the LLM.

This prompt consistently yields a condensed summary of the big stories:

```bash
QUERY="Here is today's news, summarise it in five bullet-points: $NEWS. Respond with a five bullet-point summary of today's news. You can ignore stories that are less newsworthy or important. Keep each summary to no more than 18 words. Follow this format: '//  BRIEF HEADLINE: More details about the story, summarising the key events, location etc.' "
```

Assuming all goes well and GPT-4o-mini delivers the goods, we're ready to go to press.

`Echo` it all into `/dev/usb/lp0`, and...

![The finished product, a newspaper printed on thermal paper showing the date, weather and news headlines](/images/nano-paper.webp)

Wonderful. All that's left is to schedule a `cron` job to run the script every morning, so we can wake up to our latest *Nano Newspaper*

[^1]: My Github repo tells me I started a similar project nearly two years ago, but have clearly forgotten all the fiddly bits. If only I'd written notes on *paper*.
[^2]: This printer also proudly advertises Bluetooth connectivity, which requires an Android app installed via an `.apk` from [baidu.com](https://baidu.com). No thanks.
[^3]: If you're trying this on Windows: may God go with thee, and follow Mike's [guide here](https://mike42.me/blog/2015-04-getting-a-usb-receipt-printer-working-on-windows).
[^4]: If this isn't on your system - as was the case with my Pi Zero - you can install it with the [libxml2-utils](https://manpages.debian.org/buster/libxml2-utils/xmllint.1.en.html) package.
