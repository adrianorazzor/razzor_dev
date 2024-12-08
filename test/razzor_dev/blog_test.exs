defmodule RazzorDev.BlogTest do
  use RazzorDev.DataCase

  alias RazzorDev.Blog

  describe "posts" do
    alias RazzorDev.Blog.Post

    import RazzorDev.BlogFixtures

    @invalid_attrs %{title: nil, content: nil, slug: nil, published: nil, published_at: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{
        title: "some title",
        content: "some content",
        slug: "some slug",
        published: true,
        published_at: ~N[2024-12-04 01:23:00]
      }

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.content == "some content"
      assert post.slug == "some slug"
      assert post.published == true
      assert post.published_at == ~N[2024-12-04 01:23:00]
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        title: "some updated title",
        content: "some updated content",
        slug: "some updated slug",
        published: false,
        published_at: ~N[2024-12-05 01:23:00]
      }

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.content == "some updated content"
      assert post.slug == "some updated slug"
      assert post.published == false
      assert post.published_at == ~N[2024-12-05 01:23:00]
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
