defmodule PortfolioManagement.MarketDataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PortfolioManagement.MarketData` context.
  """

  @doc """
  Generate a ticker.
  """
  def ticker_fixture(attrs \\ %{}) do
    {:ok, ticker} =
      attrs
      |> Enum.into(%{
        description: "some description",
        exchange: "some exchange",
        security_type: "some security_type",
        symbol: "some symbol"
      })
      |> PortfolioManagement.MarketData.create_ticker()

    ticker
  end

  @doc """
  Generate a option.
  """
  def option_fixture(attrs \\ %{}) do
    {:ok, option} =
      attrs
      |> Enum.into(%{

      })
      |> PortfolioManagement.MarketData.create_option()

    option
  end
end
