export function updateCountdown(dateString, displayElement, message) {
    const intervalId = setInterval(() => {
        console.log("running countdown");
        let now = new Date();
        let tomorrow = new Date(dateString);
        let remainingTime = tomorrow - now;

        var days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
        var hours = Math.floor((remainingTime / (1000 * 60 * 60)) % 24);
        var hoursString = `${days}d ${hours}h`
        if (days < 2) {
            days = days * 24
            hours = Math.floor((remainingTime / (1000 * 60 * 60)) % 24) + days;
            hoursString = `${hours}h`
        }
        if ((hours + days) < 1){
            hoursString = ''
        }
        let minutes = Math.floor((remainingTime / (1000 * 60)) % 60);
        let seconds = Math.floor((remainingTime / 1000) % 60);

        displayElement.innerHTML = `${hoursString} ${minutes}m ${seconds}s`

        if (remainingTime < 0) {
            clearInterval(intervalId);
            if (message) {
                displayElement.innerHTML = message
            } else{ displayElement.innerHTML = "Time's up!" }
        }
    }, 1000);
}