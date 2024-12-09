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

let lastScrollY = window.scrollY; // Declare at the top level
let ticking = false;

export function addNavShadow(){
  const nav = document.querySelector('.nav');
  if (lastScrollY !== 0) {
      nav.classList.add("add-shadow");
      document.getElementById('website-name').style.visibility = "visible";
      console.log("triggered");
  } else {
      nav.classList.remove("add-shadow");
      document.getElementById('website-name').style.visibility = "hidden";
  }
}

export function handleScroll() {
    lastScrollY = window.scrollY; // Update the last scroll position
    if (!ticking) {
        window.requestAnimationFrame(() => {
            addNavShadow(); // Call changeNav function
            ticking = false; // Reset ticking
        });

        ticking = true; // Set ticking to true to prevent further calls
    }
}
