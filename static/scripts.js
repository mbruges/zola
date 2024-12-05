export const connectToLiveLesson = () => {
const iframe = document.querySelector("iframe");
    const overlay = document.querySelector(".overlay");
    overlay.addEventListener("click", () => {
        window.open(iframe.src, "_blank");
    });
    var subURL = "wss://socket.maxbruges.com/ws";
    function checkLiveLesson(url) {
        webSocket = new WebSocket(url);
        webSocket.onopen = () => {
            let now = new Date().toLocaleTimeString();
        };
        webSocket.onmessage = (event) => {
            console.log(event.data);
            liveURL = event.data;
            if (liveURL.includes("abort") || liveURL.length == 0) {
                document.getElementById('learn-button-link').href = '/learn';
            } else {
                var preview = document.getElementById("live-preview");
                var button = document.getElementById("learn-button");
                preview.style.display = "block";
                button.innerHTML =
                    "Join the lesson now! <span id='live-icon'>LIVE 🔴</span>";
                preview.src = "https://learn.maxbruges.com/" + liveURL;
                document.getElementById('learn-button-link').href = 'https://learn.maxbruges.com/';
                button.href = 'https://learn.maxbruges.com/';
            }
            let now = new Date().toLocaleTimeString();
            webSocket.close();
        };
    }
    window.onload = () => {
        checkLiveLesson(subURL);
    };
}

export const toggleNightmode = () => {
  const nightmodeEnabled = document.documentElement.style.getPropertyValue('--t') !== document.documentElement.style.getPropertyValue('--b');
  localStorage.setItem('nightmode', nightmodeEnabled ? 'disabled' : 'enabled');
    const t = getComputedStyle(document.documentElement).getPropertyValue('--t');
    const b = getComputedStyle(document.documentElement).getPropertyValue('--b');
   document.documentElement.style.setProperty('--t', b);
   document.documentElement.style.setProperty('--b', t);
   if (getComputedStyle(document.documentElement).getPropertyValue('--a') == "#fcf199"){
     document.documentElement.style.setProperty('--a', "#51518a");
   } else {
     document.documentElement.style.setProperty('--a', "#fcf199");
   }
}
