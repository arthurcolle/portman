defmodule PortfolioManagement.BankingInformation.AccountNumber do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account_numbers" do
    field :value, :string
    field :account, :id
    field :account_id, :integer, foreign_key: true

    timestamps()
  end

  @doc false
  def changeset(account_number, attrs) do
    account_number
    |> cast(attrs, [:value, :account_id])
    |> validate_required([:value, :account_id])
    |> unique_constraint([:account, :account_id])
  end
end
