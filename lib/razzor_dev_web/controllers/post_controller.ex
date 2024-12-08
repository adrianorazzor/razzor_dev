defmodule RazzorDevWeb.PostController do
  use RazzorDevWeb, :controller

  alias RazzorDev.Blog
  alias RazzorDev.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    tags = Blog.list_tags()
    conn
    |> assign(:page_title, "All posts - RazzorDev Blog")
    |> assign(:page_description, "Adriano Razzor personal blog")
    |> render(:post_listing, posts: posts, tags: tags, locale: Gettext.get_locale())
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{tags: []})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    tags = parse_tags(post_params["tags"])
    post_params = Map.put(post_params, "tags", tags)

    case Blog.create_post(post_params) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/blog/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, :show, post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/blog/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/blog")
  end

  defp parse_tags(nil), do: []

  defp parse_tags(tags_string) do
    tags_string
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn name ->
      case Blog.get_tag_by_name(name) do
        nil ->
          {:ok, tag} = Blog.create_tag(%{name: name})
          tag

        tag ->
          tag
      end
    end)
  end
end
