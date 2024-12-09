defmodule RazzorDevWeb.LiveViewHooks do
  import Phoenix.Component

  @moduledoc """
    The LiveViewHooks module provides hooks that are called during the lifecycle of a LiveView.
    These hooks can be used to perform common tasks such as assigning a locale to the socket.
  """

  def on_mount(:assign_default_page_info, _params, _session, socket) do
    socket =
      socket
      |> assign(:locale, Gettext.get_locale())
      |> assign(:page_title, "RazzorDev")
      |> assign(:page_description, "RazzorDev is a blog about programming an other things.")

    {:cont, socket}
  end
end
