defmodule PortfolioManagement.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :option_id, :string, null: false
      add :option_type, :string, null: false
      add :ticker_id, references(:tickers)
      add :expiration_date, :utc_datetime
      add :days_until_expiration, :float
      add :strike_price, :float
      add :in_the_money, :bool
      add :moneyness, :float
      add :theoretical_value, :float
      add :intrinsic_value, :float
      # Extrinsic value is the difference between the market price of an option, also knowns as its premium,
      # and its intrinsic price, which is the difference between an option's strike price and the underlying
      # asset's price. Extrinsic value rises with increase in volatility in the market.
      add :extrinsic_value, :float
      add :bid_price, :float
      add :ask_price, :float
      add :bid_volume, :float
      add :ask_volume, :float
      add :open_interest, :float
      add :volume, :float
      add :high_price_day, :float
      add :low_price_day, :float
      add :open_price_day, :float
      add :close_price_day, :float
      add :high_price_all_time, :float
      add :low_price_all_time, :float
      add :last_trade_price, :float
      add :last_trade_date, :utc_datetime
      add :implied_volatility, :float
      add :delta, :float
      add :gamma, :float
      add :theta, :float
      add :vega, :float
      add :rho, :float
      add :mid_price, :float
      add :weighted_mid_price, :float
      add :change, :float
      add :change_percent, :float
      add :contract_period, :string

      timestamps()
    end
  end
end
