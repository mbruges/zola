---
title: Virtual Librarian
description: "Get AI-powered recommendations from the school library"
date: 2025-02-10
draft: false
extra:
  icon: 💳
  buttontext: Ask the Librarian
  link: "/experiments/ai-librarian.html"
---

- Simple input
- I'd like to read a book about...
- Output should be three to four suggestions to click
- EITHER: link to the book's page and libLocation
- OR: download from digital library


1) Download library catalogue
2) See what data is available
3) Populate blurbs by searching ISBN on ALibris: `https://www.alibris.com/booksearch?mtype=B&isbn=+978-0-7460-8441-0`
4) Pull blurb from id="synopsis-limited"
(not actually done this, turns out blurbs are already on th system)

---

## LOG

- Exported the file from Follett Destiny
- Asked GPT what the format was, after pasting a chunk of the raw code:
> The format of the extracted data appears to be a MARC (Machine-Readable Cataloging) record, which is commonly used in libraries for cataloging bibliographic information. Each line generally contains specific metadata fields, and various indicators or codes that signify data about books, such as titles, authors, publication details, subjects, and more.
- Installed a [marc-to-json tool](https://github.com/ubleipzig/marctools#marctojson)
- Write a python script to extract the key data from the MARC.json
- Used OpenAI embedding tool to build a ChromaDB of the books database
- Separate OpenAI instance to then encode the query and select a shortlist of 5 books that match the given query's terms against the title and blurbs
- a third and FINAL OpenAI call, this time asking the AI to select ONE option from the shortlist of 5, and give a reason.
- Fun to make use of the structured response option which the API supports now.
- Now a functioning endpoint on the flask API: `https://api.mxb.fyi/librarian?query=....`

Now, just need to come up with a front end!

- Need to kill about 5 to 10 seconds of loading. Some 'hmm, let me think' placeholders etc and loading icons
- Need to pull images as well, can that be a google images search?
- Worth doing as a pico.css page? Clean and clear etc

</details>
