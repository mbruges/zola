---
author: Max Bruges
date: 2024-10-30
title: Filters, for the children
draft: false
extra:
  icon: 🚬
---

This [Hacker News comment](https://news.ycombinator.com/item?id=41994567) started turning a cog in my brain: are we going about LLMs all wrong, by plonking them straight in the hands of the end user?

> I'm of the mind that AI, in its current state, really isn't a tool meant for an end user to interact with.  
> It feels like it's the most useful when it's transparent and you -- as an end user -- don't know that there's an LLM in the process. The best use cases seem to be those that don't require an end consumer to directly interact with an AI, but their journey through some process is assisted by an AI instead.
>> [CharlieDigital, 30/10/24](https://news.ycombinator.com/user?id=CharlieDigital)

The raw input/output pipeline has the broadest possible surface for hallucination and minimal error correction; a few too many [mad pledges of love](https://www.nytimes.com/2023/02/16/technology/bing-chatbot-microsoft-chatgpt.html) and the user will quickly assume the whole technology is bad (or worse, requite the love right back).

![Just what the doctor ordered aside](/images/filtered-cigs.webp)

I can't comment on 'grown-up' usage of chat LLMs - I think most (even tech-unsavvy) users are pretty comfortable with [text-prompts as an input](https://chat.com) - but do think there's something to be said for filtering our students' usage of them.

## Wrappers don't kill people, prompts do

Take the most prevalent (*viz* pervasive) use-cases of LLMs in schools today: generating written responses to homework tasks. Obviously, we don't *want* students to do this; it's just plagiarism with fewer steps. But we've got a doubled-up problem of unfiltered LLM output here: no wrapper means the bot can go buck-wild with its answer, and no work-ethic/morals/care from the student means minimal error-checking on their end.

We live in a world where this happens anyway, and [Google isn't getting banned](@/blog/BanGoogle.md) anytime soon.

But what if we could nudge them towards a *filtered* version of the bot, one that doesn't introduce quite as much random nonsense, and - God help us! - potentially nudges them towards some actual learning?

## Sentenced to life

In my wonderful fantasy world, our students - when given an essay homework[^1] - reach not for the raw chatbox but our carefully prepped light wrapper. Let's call it `Kickstart`.

They plonk in their homework task as before, though rather than the LLM spitting out a full essay, it returns something a little more carefully considered: sentence starters and ideas for what to write.

`Kickstart` isn't going to write their essay for them, but what it will do is get them *going*, overcoming the initial activation energy of thought.

Sentence starters are often the most effective form of scaffolding we can employ, tricking the brain into working a little like an LLM to test out what it *thinks* might be the right answer.

And what they end up writing might be wrong, but that's fine! Because they're little learning humans, not inscrutable monolithic software stacks [allocating life-saving care](https://arstechnica.com/ai/2024/10/hospitals-adopt-error-prone-ai-transcription-tools-despite-warnings/).

## A man can dream

Of course, this is a fantasy, and what reason do they have to reach for `Kickstart` rather than `openai.com`?

That being said, the path of least resistance is a powerful thing. Couple this with a tougher line on AI-generated plagiarism (and better training for staff on how to spot it), and one could nudge a few into using LLMs the right way, the way any technology is supposed to be used: as an [augmentation](@/blog/Trial-by-Error.md) - not replacement - for your brain.

[^1]: Although we all know this isn't what homework is for. Haven't you heard of [Flipped learning](https://www.sciencedirect.com/science/article/pii/S2405844022038178)?
