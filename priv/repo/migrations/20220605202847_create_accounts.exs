defmodule PortfolioManagement.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :description, :string
      add :balance, :float
      add :currency_denomination, :string
      add :transactions, references(:transactions, on_delete: :nothing)

      timestamps()
    end

    create index(:accounts, [:transactions])
  end
end
