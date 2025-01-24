---
title: Launching the A.I. Academy
description: "Preparing for the future, one after-school club at a time"
authors: ["Max Bruges"]
date: 2025-01-24
extra:
  icon: 🏫
---

![Sunrise shot of Downtown Dubai and Burj Khalifa, by David Rodrigo](/images/cropped-dubai-skyline.webp)

The best thing about my day job is the boredom. Not _my_ boredom (how could I be bored when I'm literally paid to talk about [words](@/blog/PowerOfReading.md) and [witchcraft](@/learn/textbook/macbeth.md) all day?), but the boredom on the other side of the desk: the students'. 

There is no creature on this Earth more motivated, more inquisitive, more hungry to learn _what's next_ than the child who's bored with what they're doing _right now_. If you can manage it, bottling that boredom lightning is the best part of being a teacher, and the best way to *teach*.

It's in this spirit that we - a few foolhardy Year 11s and I - have launched (probably) the city's first **After-School AI Academy.** 

## Building for us, learning to last

![Ollama running a chat model, aside](/lessons/static/chatting.gif)
*An LLM running on one of our Macbooks*

We're starting [small](@/blog/little-local-llm.md), with a simple question: how can we make this incredible new technology _our own_? 

As a child of Web 2.0 and ICT lessons, the last thing I'd want is to lock another generation into walled gardens. They need to see this technology as something they can play with and make their own, not a pay-to-use, locked-down utility managed by someone else. 

No, our Academy is all about building, running, tinkering and tweaking our own AI tools, on our own computers, under our own steam. 

## Open and free

Our first sessions have been all about learning what models are, how they're created, and - above all - the value of building and learning out in the open. We couldn't do what we do without the miraculous open-source free-for-all that is [Ollama](https://ollama.com/). Everything we do carries on in that spirit, sharing code as collaborators, not as students led by a teacher.

The group is already buzzing with applications and ideas, from processing nutritional information to virtual tour guides. I'm sure I'll be showcasing some of their work in the near-future.

If you'd like to join them or share ideas, you can [drop us a line](mailto:mbruges@reptonalbarsha.org?subject=Tell%20me%20more%20about%20the%20AI%20Academy!) and [follow along](/lessons/ai.html#2) below. 

And if *you're* reading this, academicians, keep it up. Happy hacking.

<style>
    iframe {
        border: 4px solid var(--a);
        width: 95%;
        aspect-ratio: 16 / 9;
    }

    button {
        min-width: 3em;
        overflow: hidden;
    }
</style>

<iframe
    id="lesson-view"
    src="/lessons/ai.html#2"
    class="center"
    onload="this.onload=null;loadLesson(this);console.log(this.src)"
    tabindex="0"
>
</iframe>

<script>

    const iframe = document.getElementById("lesson-view");
    function simulateKeyPress(key) {
        console.log("key pressed: " + key);
        iframe.contentWindow.focus();
        iframe.contentWindow.document.dispatchEvent(
            new KeyboardEvent("keydown", { key: key }),
        );
    }

    function toggleFullscreen() {
        let iframe = document.getElementById("lesson-view");
        let toast = iframe.contentWindow.document.getElementById("toast");
        if (!document.fullscreenElement) {
            if (iframe.requestFullscreen) {
                iframe.requestFullscreen();
                iframe.contentWindow.focus();
            }
        }
    }
</script>

<div class="center">
    <button onclick="simulateKeyPress('PageUp')"><</button>
    <button
        style="padding: 0.2em"
        title="Fullscreen"
        alt="Fullscreen"
        onclick="toggleFullscreen()"
    >
        <!--&#x26F6;-->📺
    </button>
    <button onclick="simulateKeyPress('PageDown')">></button>
</div>

<br>
