defmodule RazzorDev.Release do
  # The application name (an atom).
  @app :razzor_dev

  @moduledoc """
  The release tasks for the RazzorDev application.
  """

  # --- Migrate Function ---
  # This function is responsible for running database migrations.
  def migrate do
    Application.ensure_all_started(:razzor_dev)

    path = Application.app_dir(@app, "priv/repo/migrations")

    try do
      Ecto.Migrator.run(RazzorDev.Repo, path, :up, all: true)
      IO.puts("Migrations ran successfully.")
    rescue
      exception ->
        IO.puts("Failed to run migrations: #{Exception.message(exception)}")
        System.halt(1)
    end
  end
end
