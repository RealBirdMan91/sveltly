defmodule Sveltly.Repo.Migrations.CreateRaffles do
  use Ecto.Migration

  def change do
    create table(:raffles) do
      add :status, :string
      add :description, :text
      add :prize, :string
      add :ticket_price, :integer
      add :image_path, :string

      timestamps(type: :utc_datetime)
    end
  end
end
