defmodule RazzorDev.Blog.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Tags for blog posts.
  """

  schema "tags" do
    field(:name, :string)
    many_to_many(:posts, RazzorDev.Blog.Post, join_through: "posts_tags")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
