defmodule Sveltly.Repo do
  use Ecto.Repo,
    otp_app: :sveltly,
    adapter: Ecto.Adapters.Postgres
end
