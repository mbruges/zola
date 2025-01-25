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
