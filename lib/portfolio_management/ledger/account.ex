defmodule PortfolioManagement.Ledger.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias PortfolioManagement.Ledger.Transaction
  alias PortfolioManagement.BankingInformation.{RoutingNumber, AccountNumber}

  schema "accounts" do
    field :balance, :float
    field :currency_denomination, :string
    field :description, :string
    field :name, :string
    has_many :transactions, Transaction
    has_many :routing_numbers, RoutingNumber
    has_one :account_number_id, AccountNumber

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :description, :balance, :currency_denomination])
    |> validate_required([:name, :description, :balance, :currency_denomination])
  end
end
