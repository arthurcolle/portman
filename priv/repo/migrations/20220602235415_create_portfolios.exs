defmodule PortfolioManagement.Repo.Migrations.CreatePortfolios do
  use Ecto.Migration

  def change do
    create table(:portfolios) do
      add :portfolio_type, :string
      add :name, :string
      add :budget, :float
      add :currency_denomination, :string

      timestamps()
    end
  end
end
