---
author: Max Bruges
title: 🔧 The AI I use every day
date: 2024-09-29
description: "The simplest question is always the best"
---

# The AI I use every day

*The simplest question is always the best*

![how](https://mxb.fyi/static/how.gif)

It's been nearly two years since I started fiddling with LLMs. In many ways, they're the perfect technology to *tinker* with: zero up-front cost, straight-forward documentation, with plaintext input and output.

As with most overhyped start-ups, my tinkering has largely been in the form of writing fancy wrappers around an API. I've tested out a few - some [silly](https://maxbruges.com/bard-or-bot), some [deadly serious](https://maxbruges.com/flambards), and some making use of my [day-job pedagogy](https://maxbruges.com/codefixer) to channel the Magic Talking Computers into something useful.

## One question, one answer

But the best application I've built - the one I use every day, a dozen times a day (and the reason OpenAI and Anthropic have my credit card details) - is easily the simplest.

Sometimes, you just want the computer to do The Thing; to turn your fleshy human thoughts into clean coded commands. And that's exactly what I built `cai` to do:

![CAI in action in the terminal](https://mxb.fyi/static/cai1.gif)

One question, one actionable answer.

## Silence is a virtue

No conversation, no commentary, no buttons or widgets. Just a single call and response with an LLM, turning the unknown into the known.

For the quick things I've not learnt, or the stupid things I've forgotten, it's ideal.

And it works about 90% of the time! It's cut my StackOverflow and Arch Wiki lurking time in half. What was once a click through three forums is now a single line in the terminal.

After a couple of weeks of use, I did add a `-verbose` flag; having a few lines of explanatory commentary can be valuable when working through thornier problems. There's also a `-chat` option for follow-up questions, but I've rarely had the need to use it (much to my past-self's disappointment, and the unused overkill-SQLiteDB he set up for that purpose).

## How it works

As with all good things, it started life as a `bash`, `curl`-ing to the OpenAI endpoint. It then grew into a Python script, switching to [Anthropic's Claude](https://www.anthropic.com/news/claude-3-haiku) to include some message history (`Haiku` is an excellent little model). 

The latest iteration is pure Golang, partly to avoid the faff of Python `venv` and partly as an exercise in learning more about Go. The magic is mostly in the prompt, which I'll paste below. The fancy loading animation is `gum`, by the excellent [Charm](https://github.com/charmbracelet) collective (also responsible for `VHS`, used to produce the terminal gifs above).

Now, this little Go binary sits in my $PATH, aliased to `@`, ready to go with a single keypress. 

If this is the future of computing, give me excess of it.

---

```go
var systemPrompt string = `You are a coding and computing 
assistant called CAI. 

Respond only with the requested code or command or solution, 
ideally in a single line, defaulting to BASH script unless 
otherwise stated. 

If a more detailed explanation is needed, the user will ask 
for it. 

Always be concise. All output will be rendered on a terminal,
so do not use markdown formatting. 

You must respond only with the requested code or command or 
solution,
ideally in a single line, defaulting to BASH script unless 
otherwise stated. 

If I need a more detailed explanation, I will ask for it. 

If you are providing a single line of code, do not use any 
code markers or backticks to indicate this. 

Do not add commentary or explanation. 

If you need to add comments, use # to comment the lines out.`
```
