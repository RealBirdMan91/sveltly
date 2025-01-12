defmodule Sveltly.Admin do
  alias Sveltly.Raffles.Raffle
  alias Sveltly.Repo
  import Ecto.Query

  def list_raffles do
    Raffle
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end
end
