defmodule RazzorDevWeb.HomeLive do
  use RazzorDevWeb, :live_view
  use Gettext, backend: RazzorDevWeb.Gettext

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Home - RazzorDev")
      |> assign(:page_description, "Adriano Baungardt personal website")
      |> assign(:locale, Gettext.get_locale())
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

    {:ok, socket}
  end

  def handle_event("change_locale", %{"locale" => locale}, socket) do
    Gettext.put_locale(locale)

    socket =
      socket
      |> assign(:locale, locale)
      |> assign(:gretting_text, gettext("greeting_text"))
      |> assign(:short_intro, gettext("short_intro"))
      |> assign(:bio_text, gettext("bio_text"))
      |> assign(:skills_text, gettext("skills_text"))
      |> assign(:contact_text, gettext("contact_text"))
      |> assign(:links_text, gettext("links"))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex min-h-screen flex-col items-center justify-center px-6 py-24 text-center font-sans">
      <!-- Profile Picture -->
      <div class="mb-10 md:mb-12">
        <img
          src="/images/profile.jpeg"
          alt="Adriano"
          class="h-36 w-36 rounded-full shadow-lg md:h-40 md:w-40"
        />
      </div>
      
    <!-- Greeting Text -->
      <h1 class="mb-4 font-heading text-4xl font-bold md:mb-6 md:text-5xl">
        {@gretting_text}
      </h1>
      
    <!-- Bio Section -->
      <div class="mb-12 max-w-2xl md:mb-16">
        <p class="mb-4 text-lg font-semibold leading-relaxed md:text-xl">
          {@short_intro}
        </p>
        <p class="border-t border-gray-300 pt-4 text-base leading-loose md:text-lg dark:border-zinc-700">
          {@bio_text}
        </p>
      </div>
      
    <!-- Skills Section -->
      <div class="mb-12 w-full max-w-2xl md:mb-16">
        <h2 class="mb-6 font-heading text-2xl font-bold md:text-3xl">{@skills_text}</h2>
        <ul class="flex flex-wrap justify-center gap-3 md:gap-4">
          <li
            :for={{skill, _index} <- Enum.with_index(@skills)}
            class="group flex items-center gap-x-2 rounded-xl border border-zinc-300 px-4 py-2 shadow-sm transition-colors duration-200 hover:border-zinc-600 dark:border-zinc-700 dark:hover:border-zinc-500"
          >
            <div class="relative h-5 w-5 flex-shrink-0">
              <.skill_icon name={skill.icon} class="..." />
            </div>
            <span class="font-medium text-sm md:text-base">
              {skill.name}
            </span>
          </li>
        </ul>
      </div>
      
    <!-- Contact Section -->
      <div class="mb-10 md:mb-12">
        <.link
          href="mailto:adrianorazzor@gmail.com"
          class="px-6 py-3 font-bold text-white transition duration-200 ease-in-out bg-blue-500 hover:bg-blue-600 dark:bg-blue-600 dark:hover:bg-blue-500 rounded-full md:px-8 md:py-4"
        >
          {@contact_text}
        </.link>
      </div>
      
    <!-- Social Links -->
      <div class="flex space-x-6 md:space-x-8">
        <.link
          href="https://www.linkedin.com/in/adriano-pereira-baungardt/"
          target="_blank"
          rel="noopener noreferrer"
          class="text-black dark:text-white hover:text-zinc-800 dark:hover:text-zinc-300"
        >
          <i class="fab fa-linkedin text-3xl md:text-4xl"></i>
        </.link>
        <.link
          href="https://github.com/adrianorazzor"
          target="_blank"
          rel="noopener noreferrer"
          class="text-black dark:text-white hover:text-zinc-800 dark:hover:text-zinc-300"
        >
          <i class="fab fa-github text-3xl md:text-4xl"></i>
        </.link>
        <.link
          href="https://www.instagram.com/adrianorz/"
          target="_blank"
          rel="noopener noreferrer"
          class="text-black dark:text-white hover:text-zinc-800 dark:hover:text-zinc-300"
        >
          <i class="fab fa-instagram text-3xl md:text-4xl"></i>
        </.link>
      </div>
    </div>
    """
  end

  def skill_icon(assigns) do
    ~H"""
    <img src={"/images/skills/#{@name}"} class={@class} />
    """
  end
end
