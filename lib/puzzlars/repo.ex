defmodule Puzzlars.Repo do
  use Ecto.Repo,
    otp_app: :puzzlars,
    adapter: Ecto.Adapters.Postgres
end
