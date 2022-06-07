defmodule PortfolioManagement.TradeModelFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PortfolioManagement.TradeModel` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        book_type: "some book_type",
        budget: 120.5,
        currency_denomination: "some currency_denomination",
        name: "some name"
      })
      |> PortfolioManagement.TradeModel.create_book()

    book
  end

  @doc """
  Generate a portfolio.
  """
  def portfolio_fixture(attrs \\ %{}) do
    {:ok, portfolio} =
      attrs
      |> Enum.into(%{
        budget: 120.5,
        currency_denomination: "some currency_denomination",
        name: "some name",
        portfolio_type: "some portfolio_type"
      })
      |> PortfolioManagement.TradeModel.create_portfolio()

    portfolio
  end
end
