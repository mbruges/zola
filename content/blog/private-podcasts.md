---
title: 📻 Turning radio into podcasts
author: Max Bruges
date: 2024-09-28
---

# Making a private radio podcast for fun and (definitely no) profit

*An exercise in pettiness, podcasts and programming*

![Big Ben mid-bong](https://i.ytimg.com/vi/ZY_cmEdbqvQ/maxresdefault.jpg)
*A boy needs his bongs*

I love the BBC. But I do not love [BBC Sounds](https://www.bbc.co.uk/sounds).

It is clunky, it lacks automatic downloads, and it has an unbearable habit of advertising the podcast you are listening to *during said podcast*, with a bonus reminder that you can listen to the podcast *on the app you are currently using*.

As more and more BBC programmes vanish from open podcast platforms and into Sounds, the app feels increasingly like an attempt to build a content silo that is utterly unbecoming of a national broadcaster.

And yet: a licence-fee-payer has got to get his [pips](https://en.wikipedia.org/wiki/Greenwich_Time_Signal). But how?

Time to make our *own* Six O'Clock News Podcast, with auto-downloads, FM-quality bongs and *no Sounds announcements*.

## Crossing the streams

Back in the heady days of internet radio, Auntie gifted the world high-quality audio streams of all BBC radio stations. Sadly, these have started to disappear, though a few diehards still maintain lists of the working streams.

I won't post the streams here, but if you're interested I would recommend visiting the [Github](https://gist.github.com/bpsib/67089b959e4fa898af69fea59ad74bc3) and trying your luck.

> [](warning) These streams - and the steps discussed here - are strictly for **personal use**. As much as I find BBC Sounds objectionable and irritating, pirating BBC content is Not OK.

## `.m3u8` to `.m4a`

Now we have our stream, we need to capture it.

There are a few bespoke programs in the repos for capturing streams, but we're going to stick with the trusty workhorse of `FFMPEG`, for simplicity's sake (it's a quick `apt-get`, or `brew install` [for Mac](https://formulae.brew.sh/formula/ffmpeg)).

We pipe our stream in to `FFMPEG`, specify an output file, and it'll record away.

```bash
$ ffmpeg -i https://a.bbc.stream/live/radio4.m3u8 6-oclock-news.mp3

Opening 'http://a.bbc.stream/live/radio4.m3u8' for reading
size=     256kB time=00:00:25.64 bitrate=  81.8kbits/s speed=1.99x  
```

Great! But I don't particularly want an endless MP3 file of Radio 4, or I may accidentally listen to *Moneybox*.

So, we set a flag to limit the recording to 30 minutes. While we're at it, we'll also set a bitrate - without this, we can easily end up with a file size into the hundred of MBs - and switch to our preferred format of `.m4a`, using `-c:a aac`. A bitrate of `128k` is more than sufficient for our purposes.

Our command now looks like this:

```bash
$ ffmpeg -i https://a.bbc.stream/live/radio4.m3u8 -t 00:30:00 -c:a aac -b:a 128k 6-oclock-news.m4a
```

But a strange thing happens if you set this to run: after about 7 to 8 minutes, the recording will stop. With much painful debugging (`-loglevel` is your friend), the answer appears: the encoder is catching up with the end of the stream. When it does, it stops, satisfied with a job well done.

So, we need to add a couple more flags to let `FFMPEG` know that this is a *live* stream, and to keep going until our timer is up: `-re`. We can also add `-itsoffset` to give some breathing room between the encoding and the stream, as well as a `-reconnect` and an expanded buffer just to be safe. Our final command, then, is:

```bash
ffmpeg -itsoffset 5 -re -reconnect 1 -i https://a.bbc.stream/live/radio4.m3u8 -t 00:30:00 -c:a aac -b:a 128k -rtbufsize 20M 6-oclock-news.m4a
```

Save the command down into a handy script - something like `get-news.sh` - then set a cronjob to run it at 6pm every day: `0 18 * * * bash get-news.sh`. Obviously, you'll need your computer to be switched on for the duration of the recording. FFMPEG is light enough that it can easily run on a Pi: as good an excuse as any to dig it out from the drawer.

> [](important) The streams tend to have a delay of 20-30 secs on them, so it's worth adding in a `sleep 15` at beginning of the script to account for this.  

## Serving the podcast

> [](tip-aside) Syncthing is super-easy to set up. [Give it a go!](https://docs.syncthing.net/intro/getting-started.html)

As a quick and dirty way to get the files onto a phone for listening, Syncthing works perfectly; set it up to watch the folder containing the podcast audio files, and make sure Syncthing on the device is set up to receive them.

My preferred listening app is [AntennaPod](https://antennapod.org/): open-source and very snappy. For our purposes, it also has an easy method for adding local files: tap `Add podcast` then `Add local folder` to select the Syncthing folder containing the audio files. As soon as the files appear in the folder, they'll populate into your Episode feed (with the added bonus of being listenable offline).

![pods](https://mxb.fyi/static/personalpods.webp)

And *voila*: your own, FM-standard, *Sounds*-free **6 O'Clock News**, with auto-downloads, immediately after broadcast. Just as Lord Reith intended.

> "...in view of the widespread interest which is taken by Our People in
services which provide audio and visual material by means of broadcasting, the internet or the use of newer technologies, and of the great value of such services as means of disseminating information, education and entertainment..."
>> [Royal Charter for the BBC](http://downloads.bbc.co.uk/bbctrust/assets/files/pdf/about/how_we_govern/2016/charter.pdf), 2016
