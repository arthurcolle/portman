defmodule PortfolioManagement.Repo.Migrations.CreateAccountAccountNumbersAndRoutingNumbers do
  use Ecto.Migration

  def change do
    create table(:account_routing_numbers) do
      add :account, references(:accounts, on_delete: :nothing)
      add :routing_number, references(:routing_numbers, on_delete: :nothing)
    end

    create table(:account_account_numbers) do
      add :account, references(:accounts, on_delete: :nothing)
      add :account_number, references(:account_numbers, on_delete: :nothing)
    end
  end
end
