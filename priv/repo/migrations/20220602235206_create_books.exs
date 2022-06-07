defmodule PortfolioManagement.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :book_type, :string
      add :name, :string
      add :budget, :float
      add :currency_denomination, :string

      timestamps()
    end
  end
end
