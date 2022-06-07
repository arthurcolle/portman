defmodule PortfolioManagement.BankingInformation do
  @moduledoc """
  The BankingInformation context.
  """

  import Ecto.Query, warn: false
  alias PortfolioManagement.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias PortfolioManagement.BankingInformation.RoutingNumber

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of routing_numbers using filtrex
  filters.

  ## Examples

      iex> paginate_routing_numbers(%{})
      %{routing_numbers: [%RoutingNumber{}], ...}

  """
  @spec paginate_routing_numbers(map) :: {:ok, map} | {:error, any}
  def paginate_routing_numbers(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:routing_numbers), params["routing_number"] || %{}),
        %Scrivener.Page{} = page <- do_paginate_routing_numbers(filter, params) do
      {:ok,
        %{
          routing_numbers: page.entries,
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

  defp do_paginate_routing_numbers(filter, params) do
    RoutingNumber
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of routing_numbers.

  ## Examples

      iex> list_routing_numbers()
      [%RoutingNumber{}, ...]

  """
  def list_routing_numbers do
    Repo.all(RoutingNumber)
  end

  @doc """
  Gets a single routing_number.

  Raises `Ecto.NoResultsError` if the Routing number does not exist.

  ## Examples

      iex> get_routing_number!(123)
      %RoutingNumber{}

      iex> get_routing_number!(456)
      ** (Ecto.NoResultsError)

  """
  def get_routing_number!(id), do: Repo.get!(RoutingNumber, id)

  def get_account_for_routing_number!(routing_number_id) do
    %RoutingNumber{account_id: account_id} = Repo.get!(RoutingNumber, routing_number_id)
    PortfolioManagement.Repo.get!(PortfolioManagement.Ledger.Account, account_id)
  end

  @doc """
  Creates a routing_number.

  ## Examples

      iex> create_routing_number(%{field: value})
      {:ok, %RoutingNumber{}}

      iex> create_routing_number(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_routing_number(attrs \\ %{}) do
    %RoutingNumber{}
    |> RoutingNumber.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a routing_number.

  ## Examples

      iex> update_routing_number(routing_number, %{field: new_value})
      {:ok, %RoutingNumber{}}

      iex> update_routing_number(routing_number, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_routing_number(%RoutingNumber{} = routing_number, attrs) do
    routing_number
    |> RoutingNumber.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RoutingNumber.

  ## Examples

      iex> delete_routing_number(routing_number)
      {:ok, %RoutingNumber{}}

      iex> delete_routing_number(routing_number)
      {:error, %Ecto.Changeset{}}

  """
  def delete_routing_number(%RoutingNumber{} = routing_number) do
    Repo.delete(routing_number)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking routing_number changes.

  ## Examples

      iex> change_routing_number(routing_number)
      %Ecto.Changeset{source: %RoutingNumber{}}

  """
  def change_routing_number(%RoutingNumber{} = routing_number, attrs \\ %{}) do
    RoutingNumber.changeset(routing_number, attrs)
  end

  defp filter_config(:routing_numbers) do
    defconfig do
      text :value

    end
  end
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias PortfolioManagement.BankingInformation.AccountNumber

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of account_numbers using filtrex
  filters.

  ## Examples

      iex> paginate_account_numbers(%{})
      %{account_numbers: [%AccountNumber{}], ...}

  """
  @spec paginate_account_numbers(map) :: {:ok, map} | {:error, any}
  def paginate_account_numbers(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:account_numbers), params["account_number"] || %{}),
        %Scrivener.Page{} = page <- do_paginate_account_numbers(filter, params) do
      {:ok,
        %{
          account_numbers: page.entries,
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

  defp do_paginate_account_numbers(filter, params) do
    AccountNumber
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of account_numbers.

  ## Examples

      iex> list_account_numbers()
      [%AccountNumber{}, ...]

  """
  def list_account_numbers do
    Repo.all(AccountNumber)
  end

  @doc """
  Gets a single account_number.

  Raises `Ecto.NoResultsError` if the Account number does not exist.

  ## Examples

      iex> get_account_number!(123)
      %AccountNumber{}

      iex> get_account_number!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_number!(id), do: Repo.get!(AccountNumber, id)

  def get_account!(id), do: Repo.get!(Account, id)

  def get_account_for_account_number!(id) do
    %AccountNumber{account: account_id} = get_account_number!(id)
    get_account!(account_id)
  end

  @doc """
  Creates a account_number.

  ## Examples

      iex> create_account_number(%{field: value})
      {:ok, %AccountNumber{}}

      iex> create_account_number(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account_number(attrs \\ %{}) do
    %AccountNumber{}
    |> AccountNumber.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_number.

  ## Examples

      iex> update_account_number(account_number, %{field: new_value})
      {:ok, %AccountNumber{}}

      iex> update_account_number(account_number, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_number(%AccountNumber{} = account_number, attrs) do
    account_number
    |> AccountNumber.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AccountNumber.

  ## Examples

      iex> delete_account_number(account_number)
      {:ok, %AccountNumber{}}

      iex> delete_account_number(account_number)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_number(%AccountNumber{} = account_number) do
    Repo.delete(account_number)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_number changes.

  ## Examples

      iex> change_account_number(account_number)
      %Ecto.Changeset{source: %AccountNumber{}}

  """
  def change_account_number(%AccountNumber{} = account_number, attrs \\ %{}) do
    AccountNumber.changeset(account_number, attrs)
  end

  defp filter_config(:account_numbers) do
    defconfig do
      text :value

    end
  end
end
