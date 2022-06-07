defmodule PortfolioManagement.BankingInformationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PortfolioManagement.BankingInformation` context.
  """

  @doc """
  Generate a routing_number.
  """
  def routing_number_fixture(attrs \\ %{}) do
    {:ok, routing_number} =
      attrs
      |> Enum.into(%{
        value: "some value"
      })
      |> PortfolioManagement.BankingInformation.create_routing_number()

    routing_number
  end

  @doc """
  Generate a account_number.
  """
  def account_number_fixture(attrs \\ %{}) do
    {:ok, account_number} =
      attrs
      |> Enum.into(%{
        value: "some value"
      })
      |> PortfolioManagement.BankingInformation.create_account_number()

    account_number
  end
end
