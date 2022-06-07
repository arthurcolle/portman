defmodule PortfolioManagement.Repo.Migrations.CreateAccountNumbers do
  use Ecto.Migration

  def change do
    create table(:account_numbers) do
      add :value, :string
      add :account, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:account_numbers, [:account])
  end
end
