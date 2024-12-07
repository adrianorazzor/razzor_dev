defmodule RazzorDevWeb.HomeLive do
  use RazzorDevWeb, :live_view
  use Gettext, backend: RazzorDevWeb.Gettext


  def mount(_params, _session, socket) do
    {:ok, assign(socket, :locale, Gettext.get_locale())}
  end

  def handle_event("change_locale", %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)

    socket = socket
    |> assign(:locale, locale)
    |> assign(:hello_text, gettext("hello"))
    |> assign(:intro_text, gettext("intro_text"))
    |> assign(:contact_text, gettext("contact_me"))
    |> assign(:links_text, gettext("links"))

    {:noreply, socket}
  end

  def render(assigns) do
    assigns = assign_new(assigns, :hello_text, fn -> gettext("hello") end)
    assigns = assign_new(assigns, :intro_text, fn -> gettext("intro_text") end)
    assigns = assign_new(assigns, :contact_text, fn -> gettext("contact_me") end)
    assigns = assign_new(assigns, :links_text, fn -> gettext("links") end)

    ~H"""
    <div class="min-h-screen p-8">
      <nav class="flex justify-between items-center">
        <div class="text-xl font-bold">ADRIANO BAUNGARDT</div>
        <div class="flex items-center space-x-6">
          <div class="flex space-x-2">
            <button phx-click="change_locale" phx-value-locale="en" class={[
              "hover:text-gray-400 text-xl",
              @locale == "en" && "opacity-100" || "opacity-50"
            ]}>
              🇺🇸
            </button>
            <button phx-click="change_locale" phx-value-locale="pt_BR" class={[
              "hover:text-gray-400 text-xl",
              @locale == "pt_BR" && "opacity-100" || "opacity-50"
            ]}>
              🇧🇷
            </button>
            <button phx-click="change_locale" phx-value-locale="es" class={[
              "hover:text-gray-400 text-xl",
              @locale == "es" && "opacity-100" || "opacity-50"
            ]}>
              🇪🇸
            </button>
          </div>
          <a href={~p"/blog"} class="hover:text-gray-400">blog</a>
        </div>
      </nav>

      <div class="flex flex-col justify-center items-start min-h-[80vh] max-w-md mx-auto">
        <h1 class="text-4xl font-bold mb-4"><%= @hello_text %></h1>
        <p class="text-xl mb-4">
          <%= @intro_text %>
        </p>
        <a href="mailto:adrianorazzor@gmail.com" class="text-gray-400 hover:text-white underline">
          <%= @contact_text %>
        </a>
        <div class="flex space-x-4 mt-6">
          <a href="https://www.linkedin.com/in/adriano-pereira-baungardt/" target="_blank" rel="noopener noreferrer">
            <i class="fab fa-linkedin text-2xl"></i>
          </a>
          <a href="https://github.com/adrianorazzor" target="_blank" rel="noopener noreferrer">
            <i class="fab fa-github text-2xl"></i>
          </a>
        </div>
      </div>
    </div>
    """
  end
end
