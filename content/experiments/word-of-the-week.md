---
title: Word of the Week
description: "A printable, GPT-generated worksheet, guiding students through a new word."
date: 2024-12-01
draft: false
extra:
  icon: 🔖
  buttontext: See this week's word
  link:
  nosub: true
---

<style>
#word-page p:first-of-type {
    font-size:25px;
    font-weight:500;
    color:#485cf5;
}

#word-page h1 {
    font-family:serif;
    padding:0.1em;
    margin:0.1em !important;
}

#word-page h2 {
    font-family:serif;
}

@media print {
    #word-page {
        display: block !important;
    }
    
    nav, .title, .date-bar, footer, .post-nav {
        display: none;
    }
    
    blockquote {
        border:none;
        box-shadow:none;
        background:transparent; 
    }
}

</style>

<blockquote id='word-page'>
</blockquote>

<script>
	function dateStampFunc(daysAdjust) {
			if (daysAdjust == NaN || daysAdjust == undefined) {
				daysAdjust = 0
			} else {
				daysAdjust = parseInt(daysAdjust)
			};
			var queriedDate = new Date();
			queriedDate.setDate(queriedDate.getDate() + daysAdjust)
			var date = queriedDate.getDate();
			let stringdate = "" + date
			if (stringdate.length == 1) {
				date = "0" + stringdate
			}
			var month = queriedDate.getMonth() + 1;
			let stringmonth = "" + month
			if (stringmonth.length == 1) {
				month = "0" + stringmonth
			}
			var year = queriedDate.getFullYear();
			var dateString = year + '-' + month + '-' + date;
			return dateString
		}

	function printDiv(divName) {
		var printContents = document.getElementById(divName).innerHTML;
		var originalContents = document.body.innerHTML;

		document.body.innerHTML = printContents;
		document.body.style.background = "transparent"
		window.print();

		document.body.innerHTML = originalContents;

	}

	window.onload = () => {
		console.log('starting')
		fetch('/experiments/wotdarchive/wotd-database.json')
		.then((response) => response.json())
		.then((json) => {
			currentDate = new Date();
			currentDate = Date.parse(currentDate)
			for (let index = 0; index < json.length; index++) {
				wordDate = new Date(json[index].published).toLocaleDateString()
				wordDate = Date.parse(wordDate);
				console.log(wordDate + 'vs' + currentDate)

				if (wordDate < currentDate) {
					console.log('not this date')}
				else {
				let word = ""
				document.getElementById('word-page').innerHTML = json[index].content.replace(" of The Day is"," is... ")
					word = "" + json[index].word
					//This section tweaks the meta tags
					let desc = `Word of the Week is ${word}`
					document.querySelector('meta[property="og:title"]').setAttribute("content", desc);
					document.querySelector('meta[name="twitter:title"]').setAttribute("content", desc);
					document.getElementById('title').innerHTML = desc
					break
				}
				}})
			}

	function randomise() {
		fetch('/experiments/wotdarchive/wotd-database.json')
			.then((response) => response.json())
			.then((json) => {
				let len = json.length
				let rand = Math.floor(Math.random()*len)

					let pageDate = json[rand].published;
					let word = ""
					document.getElementById('word-page').innerHTML = json[rand].content

					word = "" + json[rand].word

					let desc = `Word of the Week is ${word}`

					document.querySelector('meta[name="description"]').setAttribute("content", desc);

					document.getElementById('title').innerHTML = desc

					window.scrollTo({
					top: 1,
					left: 1,
					behavior: "smooth",})
					})
				}

</script>
