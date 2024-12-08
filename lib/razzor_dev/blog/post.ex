defmodule RazzorDev.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  The schema for the `posts` table.
  """

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    field(:author, :string)
    field(:slug, :string)
    field(:published, :boolean, default: false)
    field(:published_at, :naive_datetime)
    many_to_many(:tags, RazzorDev.Blog.Tag, join_through: "posts_tags")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :author, :slug, :published, :published_at])
    |> put_assoc(:tags, attrs["tags"] || [])
    |> validate_required([:title, :content, :author, :slug, :published, :published_at])
    |> generate_slug()
  end

  defp generate_slug(changeset) do
    case get_change(changeset, :title) do
      nil ->
        changeset

      title ->
        slug =
          title
          |> String.downcase()
          |> String.replace(~r/[^a-z0-9]/, "-")
          |> String.replace(~r/-+/, "-")

        put_change(changeset, :slug, slug)
    end
  end
end
