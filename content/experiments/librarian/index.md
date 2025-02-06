---
title: LibrarAIn
description: "An AI-powered Librarian"
date: 2025-02-10
draft: true
extra:
  icon: 💳
  buttontext: Visit the Librarian
  link:
---

- Simple input
- I'd like to read a book about...
- Output should be three to four suggestions to click
- EITHER: link to the book's page and location
- OR: download from digital library


1) Download library catalogue
2) See what data is available
3) Populate blurbs by searching ISBN on ALibris: `https://www.alibris.com/booksearch?mtype=B&isbn=+978-0-7460-8441-0`
4) Pull blurb from id="synopsis-limited"

---

## LOG

- Exported the file from Follett Destiny
- Asked GPT what the format was, after pasting a chunk of the raw code:
> The format of the extracted data appears to be a MARC (Machine-Readable Cataloging) record, which is commonly used in libraries for cataloging bibliographic information. Each line generally contains specific metadata fields, and various indicators or codes that signify data about books, such as titles, authors, publication details, subjects, and more.
- Installed a [marc-to-json tool](https://github.com/ubleipzig/marctools#marctojson)
- Write a python script to extract the key data from the MARC.json
