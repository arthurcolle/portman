defmodule PortfolioManagement.Repo.Migrations.AddAccountIdToRoutingNumbersAndAccountNumbers do
  use Ecto.Migration

  def change do
    alter table(:routing_numbers) do
      add :account_id, references("accounts")
    end

    alter table(:account_numbers) do
      add :account_id, references("accounts")
    end
  end
end
