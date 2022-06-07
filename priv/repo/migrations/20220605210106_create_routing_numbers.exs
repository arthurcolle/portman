defmodule PortfolioManagement.Repo.Migrations.CreateRoutingNumbers do
  use Ecto.Migration

  def change do
    create table(:routing_numbers) do
      add :value, :string
      add :account, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:routing_numbers, [:account])
  end
end
