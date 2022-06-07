defmodule PortfolioManagement.BankingInformation.RoutingNumber do
  use Ecto.Schema
  import Ecto.Changeset

  schema "routing_numbers" do
    field :value, :string
    field :account_id, :integer, foreign_key: true
    timestamps()
  end

  @doc false
  def changeset(routing_number, attrs) do
    routing_number
    |> cast(attrs, [:value, :account_id])
    |> validate_required([:value, :account_id])
  end
end
