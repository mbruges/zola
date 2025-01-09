export const toggleNightmode = () => {
  const nightmodeEnabled =
    document.documentElement.style.getPropertyValue("--t") !==
    document.documentElement.style.getPropertyValue("--b");
  localStorage.setItem("nightmode", nightmodeEnabled ? "disabled" : "enabled");
  const t = getComputedStyle(document.documentElement).getPropertyValue("--t");
  const b = getComputedStyle(document.documentElement).getPropertyValue("--b");
  document.documentElement.style.setProperty("--t", b);
  document.documentElement.style.setProperty("--b", t);
  if (
    getComputedStyle(document.documentElement).getPropertyValue("--a") ==
    "#fcf199"
  ) {
    document.documentElement.style.setProperty("--a", "#51518a");
  } else {
    document.documentElement.style.setProperty("--a", "#fcf199");
  }
};

let lastScrollY = window.scrollY; // Declare at the top level
let ticking = false;
let shadowActive = false;

export function addNavShadow() {
  const nav = document.querySelector(".nav");
  if (lastScrollY !== 0 && !shadowActive) {
    nav.classList.add("add-shadow");
    shadowActive = true;
    document.getElementById("website-name").classList.add("visible");
    console.log("shadow on");
  } else if (shadowActive && lastScrollY === 0) {
    nav.classList.remove("add-shadow");
    shadowActive = false;
    document.getElementById("website-name").classList.remove("visible");
    console.log("shadow off");
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

export function toast(message) {
  const toast = document.createElement("div");
  toast.style.position = "fixed";
  toast.style.top = "-50px"; // Initially positioned off-screen
  toast.style.left = "50%";
  toast.style.opacity = "0.8";
  toast.style.transform = "translateX(-50%)";
  toast.style.backgroundColor = "#333";
  toast.style.color = "white";
  toast.style.padding = "0.5rem";
  toast.style.borderRadius = "var(--border-radius)";
  toast.style.transition = "top 0.5s";
  toast.style.zIndex = "1000";
  document.body.appendChild(toast);
  toast.textContent = message;
  toast.style.top = "20px";
  setTimeout(() => {
    toast.style.top = "-60px";
    setTimeout(() => {
      document.body.removeChild(toast);
    }, 500);
  }, 3000);
}
