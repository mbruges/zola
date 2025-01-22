---
title: Launching the A.I. Academy
description: "Preparing for the future, one after-school club at a time"
authors: ["Max Bruges"]
date: 2025-01-23
draft: true
extra:
  icon: 🎓
---


The best thing about my day job is the boredom. Not _my_ boredom (how could I be bored when I'm literally paid to [talk about words](@/blog/PowerOfReading.md) all day?), but the boredom on the other side of the desk: the students'. 

There is no creature on this Earth more motivated, more inquisitive, more hungry to learn _what's next_ than the child who's bored with what they're doing _right now_. We all know the drudgery of GCSE revision is worth it in the end, but what of the manic, distracting urge to do something else? If you can manage it, bottling that boredom lightning is the best part of being a teacher.

And it's in this spirit that we - a few foolhardy Year 11s and I - have launched (probably) the city's first After-School AI Academy. 

## Building for us, learning to last

![Ollama running a chat model, aside](/lessons/static/chatting.gif)
*Ollama in action, running on a Macbook*

We're starting [small](@/blog/little-local-llm.md), with a simple question: how can we make this incredible new technology _our own_? 

As a child of Web 2.0 and ICT lessons, the last thing I'd want is to lock another generation into walled gardens. They need to see this technology as something they can play with and make their own, not a pay-to-use, locked-down utility managed by someone else. 

No, our Academy is all about building, running, tinkering and tweaking our own AI tools, on our own computers, under our own steam. 

## Opens and free

Our first sessions have been all about learning what models are, how they're created, and - above all - the value of open source research and coding. We couldn't do what we do without the miraculous free-for-all that is Ollama, and we try to mirror that by sharing everything we do with each other. Even my hideous attempts to make sense LLMs. 

If you're reading this, academicians, keep it up. If you'd like to join them, you can follow along below. 

Happy hacking.


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
    src="/lessons/ai.html#1"
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
