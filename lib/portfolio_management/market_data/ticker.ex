defmodule PortfolioManagement.MarketData.Ticker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickers" do
    field :description, :string
    field :exchange, :string
    field :security_type, :string
    field :symbol, :string

    timestamps()
  end

  @doc false
  def changeset(ticker, attrs) do
    ticker
    |> cast(attrs, [:symbol, :description, :security_type, :exchange])
    |> validate_required([:symbol, :exchange])
  end
end
