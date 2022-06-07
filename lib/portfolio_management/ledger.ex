defmodule PortfolioManagement.Ledger do
  @moduledoc """
  The Ledger context.
  """

  import Ecto.Query, warn: false
  alias PortfolioManagement.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  import PortfolioManagement.Ledger.Account
  import PortfolioManagement.BankingInformation.RoutingNumber
  import PortfolioManagement.BankingInformation.AccountNumber



  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of accounts using filtrex
  filters.

  ## Examples

      iex> paginate_accounts(%{})
      %{accounts: [%Account{}], ...}

  """
  @spec paginate_accounts(map) :: {:ok, map} | {:error, any}
  def paginate_accounts(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:accounts), params["account"] || %{}),
        %Scrivener.Page{} = page <- do_paginate_accounts(filter, params) do
      {:ok,
        %{
          accounts: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_accounts(filter, params) do
    PortfolioManagement.Ledger.Account
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(PortfolioManagement.Ledger.Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(PortfolioManagement.Ledger.Account, id)

  # def get_routing_numbers_for_account(account_id) do
  #   accounts
  #   |> map(^get_routing_numbers_for_account)
  # end

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %PortfolioManagement.Ledger.Account{}
    |> PortfolioManagement.Ledger.Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%PortfolioManagement.Ledger.Account{} = account, attrs) do
    account
    |> PortfolioManagement.Ledger.Account.changeset(attrs)
    |> PortfolioManagement.Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%PortfolioManagement.Ledger.Account{} = account) do
    PortfolioManagement.Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%PortfolioManagement.Ledger.Account{} = account, attrs \\ %{}) do
    PortfolioManagement.Ledger.Account.changeset(account, attrs)
  end

  defp filter_config(:accounts) do
    defconfig do
      text :name
        text :description
         #TODO add config for balance of type float
      text :currency_denomination

    end
  end
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias PortfolioManagement.Ledger.Transaction

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of transactions using filtrex
  filters.

  ## Examples

      iex> paginate_transactions(%{})
      %{transactions: [%Transaction{}], ...}

  """
  @spec paginate_transactions(map) :: {:ok, map} | {:error, any}
  def paginate_transactions(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:transactions), params["transaction"] || %{}),
        %Scrivener.Page{} = page <- do_paginate_transactions(filter, params) do
      {:ok,
        %{
          transactions: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_transactions(filter, params) do
    Transaction
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{source: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp filter_config(:transactions) do
    defconfig do
       #TODO add config for amount of type float
      text :transaction_type
        date :executed_at
        date :settled_at
        text :note
        boolean :recurring

    end
  end
end
