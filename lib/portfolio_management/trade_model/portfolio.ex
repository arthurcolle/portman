defmodule PortfolioManagement.TradeModel.Portfolio do
  use Ecto.Schema
  import Ecto.Changeset

  schema "portfolios" do
    field :budget, :float
    field :currency_denomination, :string
    field :name, :string
    field :portfolio_type, :string

    timestamps()
  end

  @doc false
  def changeset(portfolio, attrs) do
    portfolio
    |> cast(attrs, [:portfolio_type, :name, :budget, :currency_denomination])
    |> validate_required([:portfolio_type, :name, :budget, :currency_denomination])
  end
end
