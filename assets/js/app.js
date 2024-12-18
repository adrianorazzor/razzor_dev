import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"
import './menu_toggle'

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// Add Hooks here
let Hooks = {}

Hooks.StoreLocale = {
  mounted() {
    let storedLocale = localStorage.getItem("locale")
    if (storedLocale) {
      this.pushEvent("change_locale", { locale: storedLocale })
    }

    this.handleEvent("store-locale", ({ locale }) => {
      localStorage.setItem("locale", locale)
    })
  }
}

let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: Hooks
})

topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()
window.liveSocket = liveSocket
