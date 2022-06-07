defmodule PortfolioManagement.Ledger.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :float
    field :executed_at, :naive_datetime
    field :note, :string
    field :recurring, :boolean, default: false
    field :settled_at, :naive_datetime
    field :transaction_type, :string
    field :to_account, :id
    field :from_account, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :transaction_type, :executed_at, :settled_at, :note, :recurring])
    |> validate_required([:amount, :transaction_type, :executed_at, :settled_at, :note, :recurring])
  end
end
