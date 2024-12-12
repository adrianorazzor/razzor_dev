export default function initDarkModeToggle() {
  // 1. Get the dark mode toggle button
  const darkModeToggle = document.getElementById("dark-mode-toggle");

  // 2. If the button doesn't exist, exit the function early
  if (!darkModeToggle) {
    return;
  }

  // 3. Apply dark mode on page load based on localStorage
  if (localStorage.getItem("dark-mode") === "enabled") {
    document.documentElement.classList.add("dark");
  }

  // 4. Add a click event listener to the button
  darkModeToggle.addEventListener("click", () => {
    // Toggle the 'dark' class on the <html> element
    document.documentElement.classList.toggle("dark");

    // Update localStorage based on the current state
    const newMode = document.documentElement.classList.contains("dark") ? "enabled" : "disabled";
    localStorage.setItem("dark-mode", newMode);
  });
}
