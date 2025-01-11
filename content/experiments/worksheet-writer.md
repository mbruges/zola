---
title: Worksheet Writer
draft: True
description: Generate independent learning tasks with GPT-4o
date: 2025-01-11
extra:
  icon: 
---

<label for="topic">Topic:</label>
<input id="topicInput" type="text" name="topic" value="" placeholder="E.g. 'Macbeth Act 1">

<label for="subjects">Subject:</label>
  <select style="background:var(--b);color:var(--t)" id="subjectsInput" name="subjects">
      <option value=""></option>
      <option value="English">English</option>
      <option value="Maths">Maths</option>
      <option value="Science">Science</option>
      <option value="History">History</option>
      <option value="Geography">Geography</option>
      <option value="Art">Art</option>
      <option value="Music">Music</option>
      <option value="Drama">Drama</option>
  </select>

<label for="years">Yeargroup:</label>
  <select id="yearInput" name="years">
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
  </select>


Any specifics to include?
<input id="additionsInput" type="text" name="additions" value="" placeholder="E.g. 'A drawing task'">
