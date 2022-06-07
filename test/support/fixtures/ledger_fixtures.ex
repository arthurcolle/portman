defmodule PortfolioManagement.LedgerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PortfolioManagement.Ledger` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        balance: 120.5,
        currency_denomination: "some currency_denomination",
        description: "some description",
        name: "some name"
      })
      |> PortfolioManagement.Ledger.create_account()

    account
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        executed_at: ~N[2022-06-04 20:40:00],
        note: "some note",
        recurring: true,
        settled_at: ~N[2022-06-04 20:40:00],
        transaction_type: "some transaction_type"
      })
      |> PortfolioManagement.Ledger.create_transaction()

    transaction
  end
end
