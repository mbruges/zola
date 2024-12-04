---
title: Trial by Error
description: "Learning the hard way, failing the right way"
author: Max Bruges
date: 2023-05-04
extra:
  icon: 🙈
---

![A trial by ordeal](/images/trial-illustration.webp "The blind-folded man is the learner, the bishop the teacher, and the monks are... OFSTED I guess")
*A trial by ordeal*

This website is a place *about* learning and a place *for* learning: as the [playground](/experiments/codeplayground.html) page testifies, this is as much a learning experience for me as it is a resource for anyone else.

Based on my [previous musings](/blog/HelloWorld), I've tried to put the principle into practice. Allow me to introduce my latest experiment in GPT and JS:
*[What Am I Doing Wrong?](/experiments/codefixer.html)*

![A screenshot of the page in action](/images/waidw-screenshot.png "I wish I could say I invented this error.")

Simply put: it's a wrapper for ChatGPT that gives you feedback on your code. Philosophically, it's a deliberate nudge away from the "fire-and-forget" approach to LLMs that their design (and decades of Google habits) tend towards. Rather than demand "make me a script to do this thing" (which The Bot is perfectly capable of doing!), this puts the impetus on the user to *attempt the problem first*, before seeking the help of the omniscient chatbot overlord.

## Creating is hard, editing is easy

"What am I doing wrong?" (or *WAIDW*, for short) is probably the most powerful question a learner can ask.

It invites effective feedback, sets a clear metric of success, and scaffolds its own response. Telling a student what a 'good one looks like' seems simple, but is extremely tricky to get right: end-products don't often foreground the most important thinking, and copying the model might mean the learner ends up focusing your efforts on what doesn't really matter.

![The Last Supper](/images/last-supper.webp "Can you pass the unleavened bread")
*Tracing 'The Last Supper' won't make you a master of perspective overnight - you need to understand the fundamentals*

"WAIDW", on the other hand, is simple to answer for anyone with domain knowledge one step above the questioner. If you know more than they do, you can't help but identify the gaps in knowledge, and offer the immediate remedy. Call it Weaponised Mansplaining; the Pedagogy of The Insufferable; the Art of [Ackshually](https://knowyourmeme.com/memes/ackchyually-actually-guy).

It also forces you, as a teacher, to focus your speech on the needs of the learner. 'Teacher talk' is a trap, particularly when it isn't dialogic. WAIDR is the perfect prompt to force even the most didactic of instructors, judo-like, to flip their desire for monologuing into an act of student-centred learning.

## Check yourself before you brick yourself

So where does this fit with the [new experiment](/experiments/codefixer.html)?

Well: The Bot is clever, but it's not got enough tokens to go full Vygotsky or Bloom on you just yet. But what it can do, very effectively, is [auto-correct](https://www.theatlantic.com/technology/archive/2023/03/ai-chatgpt-autocorrect-limitations/673338/). And essentially, that's what "WAIDW" is for the human brain: here's how I've started, now give me some wiggly red lines and tell me what to fix.

Of course, we don't want to fall into the trap of blind-copying the correction that's been given. I've got a perfectly good ['click to copy' function](/experiments/codeplayground.html#CopyButton) (thank you very much), and an earlier draft of this site had it implemented: snipping out the code to the clipboard, all set for oven-ready deployment to your failing script.

Taking that little button out is another small nudge towards the *pause-reflect-digest* cycle that one needs to actually *learn* from a mistake.

![Me typing SUDO BASH for the first time.](/images/homer.png "Me typing SUDO BASH for the first time.")
*Me typing `sudo bash` for the first time.*

[I've joked before](/blog/Trial-by-Error) about the dangers of '[bricking](https://www.howtogeek.com/126665/htg-explains-what-does-bricking-a-device-mean/)' - irreparably breaking something by copying what you don't understand - but it's a potent metaphor. Too often, as teachers, we incentivise the "do as I do" approach, and mistake mirrored compliance for actual understanding. In the worst case, our students end up building their knowledge on non-existent foundations, before some unscaffolded, unmodelled assessment suddenly [liquifies](https://www.britannica.com/video/185615/liquefaction-event-soil-particles-earthquake-combination-water) the ground and it all comes tumbling down.

If that happens, the loss of confidence can be catastrophic, and the closest to 'bricking' that a learner can get.  The process of rebuilding has to start with working out where the uncomprehending copying ends, and where the solid knowledge begins. And to get there, we start asking "What Am I Doing Wrong?"
