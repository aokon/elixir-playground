defmodule Thrall.Repo do
  use Ecto.Repo,
    otp_app: :thrall,
    adapter: Ecto.Adapters.Postgres
end
