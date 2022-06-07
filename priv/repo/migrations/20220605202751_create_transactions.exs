defmodule PortfolioManagement.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :float
      add :transaction_type, :string
      add :executed_at, :naive_datetime
      add :settled_at, :naive_datetime
      add :note, :string
      add :recurring, :boolean, default: false, null: false

      timestamps()
    end
  end
end
