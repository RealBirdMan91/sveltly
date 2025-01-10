defmodule Sveltly.Raffles do
  alias Sveltly.Raffles.Raffle
  alias Sveltly.Repo
  import Ecto.Query

  def list_raffles do
    Repo.all(Raffle)
  end

  def filter_raffles(filter) do
    Raffle
    |> withStatus(filter["status"])
    |> search_by(filter["query"])
    |> sort_by(filter["sort_by"])
    |> Repo.all()
  end

  defp search_by(query, term) when term in ["", nil], do: query

  defp search_by(query, term) do
    where(query, [r], ilike(r.prize, ^"%#{term}%"))
  end

  defp withStatus(query, status) when status in ~w(open closed upcoming) do
    where(query, status: ^status)
  end

  defp withStatus(query, _), do: query

  defp sort_by(query, "prize") do
    order_by(query, asc: :prize)
  end

  defp sort_by(query, "ticket_price_asc") do
    order_by(query, asc: :ticket_price)
  end

  defp sort_by(query, "ticket_price_desc") do
    order_by(query, desc: :ticket_price)
  end

  defp sort_by(query, _) do
    order_by(query, desc: :id)
  end

  def get_raffle!(id) do
    Repo.get!(Raffle, id)
  end

  def featured_raffles(raffle) do
    Process.sleep(5000)

    Raffle
    |> where(status: :open)
    |> where([r], r.id != ^raffle.id)
    |> order_by(desc: :ticket_price)
    |> limit(3)
    |> Repo.all()
  end
end
