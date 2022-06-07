defmodule PortfolioManagement.MarketData do
  @moduledoc """
  The MarketData context.
  """

  import Ecto.Query, warn: false
  alias PortfolioManagement.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias PortfolioManagement.MarketData.Ticker

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of tickers using filtrex
  filters.

  ## Examples

      iex> paginate_tickers(%{})
      %{tickers: [%Ticker{}], ...}

  """
  @spec paginate_tickers(map) :: {:ok, map} | {:error, any}
  def paginate_tickers(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:tickers), params["ticker"] || %{}),
        %Scrivener.Page{} = page <- do_paginate_tickers(filter, params) do
      {:ok,
        %{
          tickers: page.entries,
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

  defp do_paginate_tickers(filter, params) do
    Ticker
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of tickers.

  ## Examples

      iex> list_tickers()
      [%Ticker{}, ...]

  """
  def list_tickers do
    Repo.all(Ticker)
  end

  @doc """
  Gets a single ticker.

  Raises `Ecto.NoResultsError` if the Ticker does not exist.

  ## Examples

      iex> get_ticker!(123)
      %Ticker{}

      iex> get_ticker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticker!(id), do: Repo.get!(Ticker, id)

  @doc """
  Creates a ticker.

  ## Examples

      iex> create_ticker(%{field: value})
      {:ok, %Ticker{}}

      iex> create_ticker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticker(attrs \\ %{}) do
    %Ticker{}
    |> Ticker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticker.

  ## Examples

      iex> update_ticker(ticker, %{field: new_value})
      {:ok, %Ticker{}}

      iex> update_ticker(ticker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticker(%Ticker{} = ticker, attrs) do
    ticker
    |> Ticker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ticker.

  ## Examples

      iex> delete_ticker(ticker)
      {:ok, %Ticker{}}

      iex> delete_ticker(ticker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticker(%Ticker{} = ticker) do
    Repo.delete(ticker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticker changes.

  ## Examples

      iex> change_ticker(ticker)
      %Ecto.Changeset{source: %Ticker{}}

  """
  def change_ticker(%Ticker{} = ticker, attrs \\ %{}) do
    Ticker.changeset(ticker, attrs)
  end

  defp filter_config(:tickers) do
    defconfig do
      text :symbol
        text :description
        text :security_type
        text :exchange
        
    end
  end
end
