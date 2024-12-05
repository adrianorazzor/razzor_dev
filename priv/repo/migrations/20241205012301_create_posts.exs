defmodule RazzorDev.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :string
      add :slug, :string
      add :published, :boolean, default: false, null: false
      add :published_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
