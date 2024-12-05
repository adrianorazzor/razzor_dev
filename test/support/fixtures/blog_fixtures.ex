defmodule RazzorDev.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RazzorDev.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published: true,
        published_at: ~N[2024-12-04 01:23:00],
        slug: "some slug",
        title: "some title"
      })
      |> RazzorDev.Blog.create_post()

    post
  end
end
