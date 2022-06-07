defmodule PortfolioManagement.Repo.Migrations.AddAccountsToTransactions do
  use Ecto.Migration

  def change do
    alter table(:transactions) do
      add :from_account, references(:accounts, on_delete: :nothing)
      add :to_account, references(:accounts, on_delete: :nothing)
    end

    create index(:transactions, [:to_account])
    create index(:transactions, [:from_account])
  end
end
