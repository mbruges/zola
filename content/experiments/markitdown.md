---
title: Get Text
description: "Extract plain text from `pdf` files using the [Markitdown](https://github.com/microsoft/markitdown) library."
date: 2024-12-21
extra:
  icon: ⌨
  center: true
---

<form action = "https://api.mxb.fyi/mdown" method = "POST"
   enctype = "multipart/form-data" onsubmit="event.preventDefault(); let output = document.getElementById('output'); output.style.visibility = 'visible'; output.innerHTML = '<span class=load>⏳</span>';  let formData = new FormData(this); fetch(this.action, { method: 'POST', body: formData })
   .then(response => response.text())
   .then(data => document.getElementById('output').innerText = data);">
       <input type = "file" name = "file" accept=".pdf" onchange="document.getElementById('submit').click()"/>
  <input id=submit type = "submit" hidden/>
</form>

<blockquote id=output style="visibility:hidden;text-align:left;"></blockquote>
