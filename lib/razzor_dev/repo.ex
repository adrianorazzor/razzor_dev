defmodule RazzorDev.Repo do
  use Ecto.Repo,
    otp_app: :razzor_dev,
    adapter: Ecto.Adapters.Postgres
end
