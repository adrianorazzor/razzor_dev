defmodule RazzorDev.Release do
  @app :razzor_dev

  @moduledoc """
  The release tasks for the RazzorDev application.
  """

  def migrate do
    Application.ensure_all_started(:razzor_dev)

    path = Application.app_dir(@app, "priv/repo/migrations")
    IO.puts("Running migrations for #{@app}")
    Ecto.Migrator.run(RazzorDev.Repo, path, :up, all: true)

    IO.puts("Migrations complete")
  end
end
