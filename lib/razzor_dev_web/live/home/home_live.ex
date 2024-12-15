defmodule RazzorDevWeb.HomeLive do
  use RazzorDevWeb, :live_view
  use Gettext, backend: RazzorDevWeb.Gettext

  def mount(_params, _session, socket) do
    socket = assign_defaults(socket)
    {:ok, socket}
  end

  def handle_event("change_locale", %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)
    socket = assign_defaults(socket, locale)
    {:noreply, socket}
  end

  def assign_defaults(socket, locale \\ Gettext.get_locale()) do
    socket
    |> assign(:page_title, "Home - RazzorDev")
    |> assign(:page_description, "Adriano Baungardt personal website")
    |> assign(:locale, locale)
    |> assign(:gretting_text, gettext("greeting_text"))
    |> assign(:short_intro, gettext("short_intro"))
    |> assign(:bio_text, gettext("bio_text"))
    |> assign(:skills_text, gettext("skills_text"))
    |> assign(:contact_text, gettext("contact_text"))
    |> assign(:links_text, gettext("links"))
    |> assign(:skills, [
      %{name: "Java", icon: "java.svg"},
      %{name: "Flutter", icon: "flutter.svg"},
      %{name: "Phoenix", icon: "phoenix.svg"},
      %{name: "PostgreSQL", icon: "postgresql.svg"}
    ])
  end

  def skill_icon(assigns) do
    ~H"""
    <img src={"/images/skills/#{@name}"} class={@class} alt={@name} />
    """
  end

  def render(assigns) do
    ~H"""
    <div class="flex min-h-screen flex-col items-center justify-center px-6 text-center font-sans">
      <!-- Profile Picture -->
      <div class="mb-6 md:mb-10">
        <img
          src="/images/profile.jpeg"
          alt="Adriano"
          class="h-36 w-36 rounded-full shadow-lg md:h-40 md:w-40 border-4 border-accent"
        />
      </div>
      
    <!-- Greeting Text -->
      <h1 class="mb-2 font-heading text-2xl font-bold md:mb-6 md:text-5xl text-accent">
        {@gretting_text}
      </h1>
      
    <!-- Bio Section -->
      <div class="mb-4 max-w-2xl md:mb-16">
        <p class="mb-4 text-lg font-semibold leading-relaxed md:text-xl">
          {@short_intro}
        </p>
        <p class="border-t border-accent pt-4 text-base leading-loose md:text-lg">
          {@bio_text}
        </p>
      </div>
      
    <!-- Skills Section -->
      <div class="mb-8 w-full max-w-2xl md:mb-16">
        <h2 class="mb-4 font-heading text-2xl font-bold md:text-3xl text-accent">{@skills_text}</h2>
        <ul class="flex flex-wrap justify-center gap-2 md:gap-4">
          <li
            :for={{skill, _index} <- Enum.with_index(@skills)}
            class="group flex items-center gap-x-2 rounded-xl border border-accent px-4 py-2 shadow-sm transition-all duration-200 hover:bg-accent hover:text-light"
          >
            <div class="relative h-5 w-5 flex-shrink-0">
              <.skill_icon
                name={skill.icon}
                class="transition-colors duration-200 group-hover:text-light"
              />
            </div>
            <span class="font-medium text-sm md:text-base">
              {skill.name}
            </span>
          </li>
        </ul>
      </div>
      
    <!-- Contact Section -->
      <div class="mb-8 md:mb-12">
        <.link
          href="mailto:adrianorazzor@gmail.com"
          class="px-6 py-3 font-bold bg-accent hover:bg-accentDark text-light transition duration-200 rounded-full md:px-8 md:py-4"
        >
          {@contact_text}
        </.link>
      </div>
      
    <!-- Social Links -->
      <div class="flex space-x-4 md:space-x-8">
        <.link
          href="https://www.linkedin.com/in/adriano-pereira-baungardt/"
          target="_blank"
          rel="noopener noreferrer"
          class="social-link"
        >
          <i class="fab fa-linkedin text-3xl md:text-4xl"></i>
        </.link>
        <.link
          href="https://github.com/adrianorazzor"
          target="_blank"
          rel="noopener noreferrer"
          class="social-link"
        >
          <i class="fab fa-github text-3xl md:text-4xl"></i>
        </.link>
        <.link
          href="https://www.instagram.com/adrianorz/"
          target="_blank"
          rel="noopener noreferrer"
          class="social-link"
        >
          <i class="fab fa-instagram text-3xl md:text-4xl"></i>
        </.link>
      </div>
    </div>
    """
  end
end
