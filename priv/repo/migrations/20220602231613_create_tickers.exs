defmodule PortfolioManagement.Repo.Migrations.CreateTickers do
  use Ecto.Migration

  def change do
    create table(:tickers) do
      add :symbol, :string
      add :description, :string
      add :security_type, :string
      add :exchange, :string

      timestamps()
    end
  end
end
