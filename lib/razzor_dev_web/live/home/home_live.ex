defmodule RazzorDevWeb.HomeLive do
  use RazzorDevWeb, :live_view
  use Gettext, backend: RazzorDevWeb.Gettext

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Home - RazzorDev")
      |> assign(:page_description, "Adriano Razzor personal website")
      |> assign(:locale, Gettext.get_locale())

    {:ok, socket}
  end

  def handle_event("change_locale", %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)

    socket =
      socket
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
    <div class="flex flex-col justify-center items-center min-h-screen text-center px-4">
      <h1 class="text-4xl font-bold mb-4 animate-slide-in">{@hello_text}</h1>
      <p class="text-xl mb-4">
        <span class="typewriter">
        {@intro_text}
        </span>
      </p>
      <a href="mailto:adrianorazzor@gmail.com" class="text-gray-400 hover:text-white underline">
        {@contact_text}
      </a>
      <div class="flex space-x-4 mt-6 justify-center">
        <a
          href="https://www.linkedin.com/in/adriano-pereira-baungardt/"
          target="_blank"
          rel="noopener noreferrer"
        >
          <i class="fab fa-linkedin text-2xl"></i>
        </a>
        <a href="https://github.com/adrianorazzor" target="_blank" rel="noopener noreferrer">
          <i class="fab fa-github text-2xl"></i>
        </a>
      </div>
    </div>
    """
  end
end
