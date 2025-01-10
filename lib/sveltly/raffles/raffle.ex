defmodule Sveltly.Raffles.Raffle do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:__meta__]}

  schema "raffles" do
    field :status, Ecto.Enum, values: [:upcoming, :open, :closed], default: :upcoming
    field :description, :string
    field :prize, :string
    field :ticket_price, :integer, default: 1
    field :image_path, :string, default: "/images/placeholder.jpg"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(raffle, attrs) do
    raffle
    |> cast(attrs, [:status, :description, :prize, :ticket_price, :image_path])
    |> validate_required([:status, :description, :prize, :ticket_price, :image_path])
  end
end
