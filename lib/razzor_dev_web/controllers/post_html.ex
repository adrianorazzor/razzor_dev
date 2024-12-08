defmodule RazzorDevWeb.PostHTML do
  use RazzorDevWeb, :html
  use Gettext, backend: RazzorDevWeb.Gettext

  embed_templates "posts_html/*"
end
