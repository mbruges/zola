---
title: Making a little, local LLM
date: 2025-01-04
author: Max Bruges
description: 'How to set up a tiny and useful AI on the most knackered of hardware.'
draft: false
extra:
 icon: 🔬
---

I've been using [my nifty terminal helper](@/blog/howdoi.md) to write the `bash` commands that my brain refuses to remember. It's quick and accurate (enough); the best tool yet I've built using an LLM.

![The Little Engine That Could aside](/images/little-engine-could.webp)

The only downside is its reliance on the Claude [API](https://support.anthropic.com/en/collections/5370014-anthropic-api-api-console), which means it's useless without an internet connection and a credit card[^1].

But can we get another version to run *locally*? No APIs, no tech companies [leaking our data](https://www.law.com/legaltechnews/2024/03/20/legal-industry-players-missed-a-microsoft-ai-loophole-that-could-expose-confidential-data/); just our own little AI, on our own computer.

In short: yes. But we need to be clever about it.

[**🛠 Click here to jump straight to the HOW-TO 🛠**](#how)

## Super Models

A quick refresher on the basics, first.

'AI' bots like ChatGPT and Claude are powered by **Large Language Models** (LLMs). The margins of this blog are too small (and its author insufficiently STEM'd) to contain a full explanation of how these work, but essentially they're programs for predicting patterns of words.

These predictions are made based on *parameters* drawn from massive bodies of text. Us internet-connected humans have been merrily churning out text to the Web for decades, and the LLMs ingest this to 'learn' what words usually come after each other.

![NYT frontpage aside](/images/nyt-frontpage.webp)
*Hoover fast and break [copyright](https://www.bbc.com/news/technology-67826601).*

Models differ from one another in their training data and their weightings: what stuff the LLM has read and what it attaches importance to. Some models lean more towards coding-related data, others are trained on specialist material to suit their use-case.

In the beginning, bigger was better: the more data you hoovered up, the more parameters your model could contain and the better its responses could be. OpenAI's GPT-2 contained 1.5 billion parameters when it was released in 2019; by 2024, their GPT-4 model had [somewhere](https://the-decoder.com/gpt-4-architecture-datasets-costs-and-more-leaked/) north of 1.4 **trillion**.


The problem with such massive models is that they need similarly colossal hardware to actually run. There's a reason Nvidia is [now the most valuable company on the planet](https://www.bloomberg.com/news/articles/2024-06-18/nvidia-becomes-world-s-largest-firm-as-ai-rally-steams-ahead?srnd=homepage-americas&sref=CIpmV6x8): in the AI gold-rush, they sell the biggest shovels. Shovels that sell for $40,000 and [use more power than a house](https://www.tomshardware.com/tech-industry/nvidias-h100-gpus-will-consume-more-power-than-some-countries-each-gpu-consumes-700w-of-power-35-million-are-expected-to-be-sold-in-the-coming-year).

Somehow, I don't think my 9-year old Thinkpad is quite going to cut it with a top-end model.

## Small is beautiful

Although the mega-models tend to get the headlines, there have been some fascinating developments down at the other end of the scale, too. [Microsoft's Phi](https://azure.microsoft.com/en-us/blog/introducing-phi-3-redefining-whats-possible-with-slms/) and [Google's Gemma](https://blog.google/technology/developers/gemma-open-models/) models are - amongst others - tailored to use a much smaller sets of parameters, to deliver usable performance on much skimpier hardware.

![Timeline of SLMs, from https://arxiv.org/pdf/2409.15790](/images/slm-timeline.webp)
*A timeline of Small Language Models[^2]*

The thinking here is that lots of AI tasks can actually be handled using smaller models, running directly on users' devices, rather than having to send requests off to energy- (and capital-) hungry data centres full of chuntering [H100s](https://en.wikipedia.org/wiki/Hopper_(microarchitecture)).

And they're getting [pretty good](https://www.technologyreview.com/2025/01/03/1108800/small-language-models-ai-breakthrough-technologies-2025/).

## Yes We Qwen {#qwen}

I've tinkered with Phi and Gemma. While both are fairly capable, they're still a little on the large side. My poor X1 isn't overflowing with RAM - and lacks any discrete GPU - so every MB counts.

The [latest and smallest Qwen-coder model](https://huggingface.co/Qwen/Qwen2.5-0.5B), on the other hand, is positively *minute*: a mere 500MB! That's half the size of GPT-2, but massively more coherent and capable.

![qwen logo aside](/images/qwenlogo.webp)
*Just [don't ask](/images/xi.gif) about [Winnie The Pooh](https://en.wikipedia.org/wiki/Censorship_of_Winnie-the-Pooh_in_China)*

It won't write beautiful sonnets or [fall in love with journalists](https://www.nytimes.com/2023/02/16/technology/bing-chatbot-microsoft-chatgpt.html), but it will pump out passable commands at a snappy pace, with a minimal RAM footprint.

Let's give it a whirl.

## How To 🛠 {#how}

### 1) Install Ollama

[Ollama](https://ollama.com/) is the go-to software for quickly downloading and running different models. They've an [extensive catalogue](https://ollama.com/search) of pre-packaged LLMs that can be pulled with a single command, and a rudimentary chat interface on the command line. I tend to stick with the CLI version, but you can also set up [OpenWebUI](https://github.com/open-webui/open-webui) for a nice front-end.

You can [download the latest version of Ollama here](https://ollama.com/download).

### 2) Download the model

There are plenty of small language models to choose from. My [current preference](#qwen) is for Alibaba's [Qwen2.5 Coder](https://ollama.com/library/qwen2.5-coder:0.5b) model, clocking in at a tiddly 0.5b parameters. Your mileage may vary, so do poke around the catalogue, and perhaps try Gemma or Phi.

To download the model, run:

```bash
ollama pull qwen2.5-coder:0.5b
```

### 3) Write the Modelfile

This Qwen model is already weighted towards coding queries, but we want to further refine it to suit our use-case of generating `Bash` commands.

To do this we make a `Modelfile`, a set of instructions to tweak the model towards our needs (my [Modelfile is here](/files/Modelfile_cai.txt), which you can copy and paste). First, we specify which model we're basing our tweaked version on:

```
FROM qwen2.5-coder:0.5b
```

Then we set the most important part of the Modelfile, the system prompt:

```
SYSTEM "You are an excellent assistant called CAI. You specialise in generating Bash scripts and commands for use on Unix systems. Respond only with the correct command for the given query. Do not provide any commentary, only respond with the command."
```

Given how small our model is already, we want to keep this as brief as possible. From trial and error, I've found this to _mostly_ keep CAI on task with delivering one-liners.

Finally, we set the temperature - where on the creative/consistent spectrum we want the model to fall:

```
PARAMETER temperature 0.7
```

You can also set other parameters like the size of the context window, but this will do for now.

### 4) Run the new, local assistant

With the Modelfile prepared, we can now ask Ollama to build the new model. We'll call it `cai`:

```bash
ollama create cai -f /path/to/Modelfile
```

Once it's created, we can now start running it. To ask the model a question, simply use the `ollama run cai`, followed by the query.

Integrating that with my little `cai` [shell wrapper](@/blog/howdoi.md), we end up with:

![screen recording of CAI in action](/images/ollama-cai.gif)
*Practically instant, and certainly quicker than an API call*

And there we have it: a fully local, fully offline, fully free command-line assistant. One that *won't* fry a knackered Thinkpad.

[^1]: Thankfully just pennies here and there, rather than £20 a month like [some sort of mug](https://www.anthropic.com/pricing). But still.
[^2]: From [Lu et al.](https://arxiv.org/pdf/2409.15790]), 2024
