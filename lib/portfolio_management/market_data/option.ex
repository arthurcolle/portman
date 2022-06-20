defmodule PortfolioManagement.MarketData.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "options" do
    field :option_id, :string
    field :option_type, :string
    field :ticker_id, :id
    field :expiration_date, :utc_datetime
    field :days_until_expiration, :float
    field :strike_price, :float
    field :in_the_money, :boolean
    field :moneyness, :float
    field :theoretical_value, :float
    field :intrinsic_value, :float
    field :extrinsic_value, :float
    field :bid_price, :float
    field :ask_price, :float
    field :bid_volume, :float
    field :ask_volume, :float
    field :open_interest, :float
    field :volume, :float
    field :high_price_day, :float
    field :low_price_day, :float
    field :open_price_day, :float
    field :close_price_day, :float
    field :high_price_all_time, :float
    field :low_price_all_time, :float
    field :last_trade_price, :float
    field :last_trade_date, :utc_datetime
    field :implied_volatility, :float
    field :delta, :float
    field :gamma, :float
    field :theta, :float
    field :vega, :float
    field :rho, :float
    field :mid_price, :float
    field :weighted_mid_price, :float
    field :change, :float
    field :change_percent, :float
    field :contract_period, :string

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [])
    |> validate_required([])
  end
end
