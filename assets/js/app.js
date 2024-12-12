import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"
import initDarkModeToggle from "./components/dark_mode";

document.addEventListener("DOMContentLoaded", () => {
  initDarkModeToggle();
});

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// Add Hooks here
let Hooks = {}

Hooks.StoreLocale = {
  mounted() {
    // Load stored locale on mount
    let storedLocale = localStorage.getItem("locale")
    if (storedLocale) {
      this.pushEvent("change_locale", { locale: storedLocale })
    }

    // Listen for locale changes
    this.handleEvent("store-locale", ({ locale }) => {
      localStorage.setItem("locale", locale)
    })
  }
}

// Update LiveSocket initialization to include hooks
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: Hooks  // Add hooks here
})

// Rest of your existing code
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()

window.liveSocket = liveSocket