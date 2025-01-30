---
title: Machine learning in the margins
description: "Using AI to explain words and scaffold reading"
authors: ["Max Bruges"]
date: 2025-01-20
draft: false
extra:
  icon: 💬
---

Decoding vocabulary is often the first stumbling block for a developing reader.

But with some help from GPT-4o and some trusty HTML, we can give our learners a chance to vault these blocks and stay in the flow.

![A tiger](/images/tiger-forest.webp)
*What immortal LLM could frame thy fearful symmetry?*

## Preempt, pre-teach, prepare

When reading, one doesn't need to [know every word](@/blog/PowerOfReading.md), but if a critical mass of unknowns is reached then understanding will collapse; or, worse, misunderstanding will creep in. 

The ['pre-teach'](https://cer.schools.nsw.gov.au/content/dam/doe/sws/schools/c/cer/localcontent/pre-teach_vocab.pdf) is a classic, [Lemov-approved](https://teachlikeachampion.org/blog/active-practice-key-vocabulary/) method for tackling this. Preempt the sticking points, prioritise their necessity, then define those words and contextualise them. 

At the same time, we don't want to overload our learners with vocabulary that it breaks the flow of reading. It's a trap I see new teachers fall into constantly; they give so much time and cognitive load over to learning the individual words that there's no space left for the text itself. What's the use of knowing 'ecstasy' and 'fumbling' if you miss the desperate panic of [the whole line](https://www.poetryfoundation.org/poems/46560/dulce-et-decorum-est)?

Vocabulary needs to be a buffet, not *foie-gras* force-feeding. Better that some words remain untaught, if it leaves room for learners to digest the text. 

## Generating definitions 

I've slowly been building out the learning resources on this site, including all the anthology poetry for Pearson [iGCSE](/learn/textbook/?filter=ks4) and [iA-Level](/learn/textbook/?filter=ks5) English Literature. These poems range in difficulty from the straight-forward to the archaic, but all need some level of vocabulary decoding before they're understood (in spite of what [Mr. Eliot](https://citatis.com/a4233/04dd7/) might say).

Deciding which words to decode - and how to decode them - is often the last thing one thinks to do, particularly in the rush of photocopying/marking/coffee-ing that makes up most of a teacher's day. So I've built a quick, AI-powered tool to kickstart[^1] the process. 

The tool reads through the given text, selects words it thinks are challenging *and* crucial to the understanding of the text, then generates brief, context-accurate definitions:

![GPT-4o generating vocabulary](/images/vocab.gif)

The first iterations were good, but far too thorough, churning out definitions lists that covered half the words in the text. That's no good: the sweet spot for a poem of average difficulty ought to be no more than seven, if only for [the sake of cognitive load](https://en.wikipedia.org/wiki/The_Magical_Number_Seven%2C_Plus_or_Minus_Two), so the model is forced to limit itself. 

Not only that, but we want to keep the definitions *as brief as possible*. Again, our intention here isn't to make our students world experts in the vocabulary, but to give them enough of a gist that they can skate over misunderstanding and focus on the main task: the reading.

## Displaying definitions

But getting these definitions is only half of the challenge. What really matters is how they are presented. Good teachers avoid starting the lesson with de-contextualised keyword instruction: far better to observe the word in its natural habitat of the text. We also want to slowly reveal the vocabulary at the most suitable time - when the student really needs it - to avoid breaking the all-important reading flow. 

In the medium of dead trees, we're a little limited as to what we can do. Write the definitions as footnotes? Put them in line? Dish them out as post-its? Either way, you're adding to the textual clutter on the page, potentially increasing the challenge of decoding for the struggling reader.

The digital space affords us much more freedom to choose how and when the new vocabulary decoding happens. Consider the stanza below, from [*'The Tyger'*](@/learn/textbook/the-tyger.md) :

<center>

<style>
    abbr {
        background-color: color-mix(in srgb, var(--a), transparent 80%);
        font-family: sans-serif;
        text-decoration: none;
        color: var(--t);
        padding-left: 0.2em;
        padding-right: 0.2em;
        margin-left: -0.2em;
        margin-right: -0.2em;
        position: relative;
        cursor: help;
        border: 1px solid transparent;
        background-color: transparent !important;
        border-bottom: 1pt dashed var(--a) !important;
        border-radius: 0px;
    }
    abbr:hover, abbr:focus {
        border: 1px solid var(--a) !important;
    }

    abbr:hover::after,
    abbr:focus::after {
      content: attr(data-title);
      font-size: 0.85em;
      padding-bottom: 3em;
      position: absolute;
      left: 50%;
      transform: translate(-50%, -0.25rem);
      bottom: 82%;
      min-width: 15em;
      text-overflow: ellipsis;
      text-align: center;
      background-color: var(--a);
      color: var(--b);
      box-shadow: 1px 1px 5px 0 rgba(0,0,0,0.4);
      font-size: 14px;
      padding: 3px 5px;
      z-index: 999;
    }

    .def:hover::after,
    .def:focus::after{
        background-color: var(--b);
        color: var(--t);
        font-style: italic;
        bottom: -1.55rem;
        border: 1pt dashed var(--a) !important;
        max-height: 1.1rem;
        line-height: 0.9em;
        height:1.1em;
        overflow-y:auto;
    }

    @media screen and (max-width: 500px) {
        abbr:hover::after,
        abbr:focus::after {
            left:110%
        }
    }
  </style>
<div id=snippet style="border: 3pt solid var(--a); border-radius:var(--border-radius);max-width:fit-content; padding:1.5em">
    <p>Tyger Tyger, burning bright,<br>
    In the forests of the night;<br>
    What <abbr class="def" data-title="(adj) god-like" tabindex="3">immortal</abbr> hand or eye,<br>
    Could <abbr class="def" data-title="(v) create, build" tabindex="4">frame</abbr> thy fearful <abbr class="def" data-title="(n) matching pattern of stripes" tabindex="5">symmetry</abbr>?</p>
</div>
</center>

The text is presented as cleanly as we can manage. No footnotes, no asterisks, no pre-populated annotations. The only indicator that there is more information for some words is the lightly dotted line. This draws the mouse or finger of the learner, and on contact...

![An showing The Tyger displaying annotations](/images/tyger-recording.gif)

...a quick, short definition. Not enough for a dictionary, nor enough for full understanding of all the word's uses, but enough for now, to keep them going. And so they do: the mouse moves off, the definition disappears, and the learner keeps reading.

The beauty of this approach? It differentiates by design. The student isn't *obligated* to read the definition; if they can make it through the line without hovering on the word, focussing on the flow instead, then they can. 

A good vocabulary list should allow struggling readers to walk, and able readers to fly. No more stumbling, just reading and - eventually - understanding.

## What next?

Time to put the tool to use. You ought to start seeing definitions appearing on [Extracts](@/learn/textbook/_index.md) over the next few days. Through some fiddling with Zola shortcodes, there's an autogenerated [vocabulary list](@/experiments/vocabulary.md) of all the words defined across the site. 

In addition to these definitions, you may see some *annotations* showing up (but that's a post for later).

I'll see if I can get the tool working as a web [experiment](@/experiments/_index.md), too. Watch this space!

[^1]: In the spirit of the [earlier experiment](@/blog/filtered-unfiltered.md), of course.
