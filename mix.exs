defmodule RazzorDev.MixProject do
  use Mix.Project

  def project do
    [
      app: :razzor_dev,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {RazzorDev.Application, []},
      extra_applications: [:logger, :runtime_tools, :ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bcrypt_elixir, "~> 3.0"},
      {:phoenix, "~> 1.7.17"},
      {:phoenix_ecto, "~> 4.6.3"},
      {:phoenix_html, "~> 4.1"},
      {:ecto_sql, "~> 3.12.1"},
      {:postgrex, "~> 0.19.3"},
      {:ecto, "~> 3.12.5"},
      {:plug_cowboy, "~> 2.7.2"},
      {:phoenix_live_reload, "~> 1.5.3", only: :dev},
      # TODO bump on release to {:phoenix_live_view, "~> 1.0.0"},
      # {:phoenix_live_view, "~> 1.0.0-rc.1", override: true},
      {:phoenix_live_view, "~> 1.0"},
      {:floki, ">= 0.37.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.5"},
      {:esbuild, "~> 0.8.2", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.4", runtime: Mix.env() == :dev},
      {
        :heroicons,
        # These two lines are essential!
        # Make the 'assets' directory available
        github: "tailwindlabs/heroicons",
        tag: "v2.1.1",
        sparse: "optimized",
        app: false,
        compile: true,
        build_path: "_build",
        deps_path: "deps",
        source_url: "https://github.com/tailwindlabs/heroicons",
        paths: ["lib", "priv/static"],
        depth: 1
      },
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.19"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.26.2"},
      {:jason, "~> 1.4.4"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, "~> 1.6.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind razzor_dev", "esbuild razzor_dev"],
      "assets.deploy": [
        "tailwind razzor_dev --minify",
        "esbuild razzor_dev --minify",
        "phx.digest"
      ]
    ]
  end

  def assets do
    [
      # ...
      custom_paths: %{
        "/favicon.ico" => "priv/static/favicon.ico"
      }
    ]
  end
end
