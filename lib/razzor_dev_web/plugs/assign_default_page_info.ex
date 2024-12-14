defmodule RazzorDevWeb.Plugs.AssignDefaultPageInfo do
  import Plug.Conn
  import Gettext

  @moduledoc """
  Assigns default page information to the connection.
  """

  @default_title "RazzorDev"
  @default_description "RazzorDev is a blog about programming an other things."

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> assign(:locale, get_locale())
    |> assign(:page_title, @default_title)
    |> assign(:page_description, @default_description)
  end
end
