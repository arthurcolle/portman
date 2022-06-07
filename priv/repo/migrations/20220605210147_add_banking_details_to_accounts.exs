defmodule PortfolioManagement.Repo.Migrations.AddBankingDetailsToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :institution_name, :string
      add :account_number, :string
      add :routing_number, :string
    end
  end
end
