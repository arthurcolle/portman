defmodule PortfolioManagementWeb.TickerController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.MarketData
  alias PortfolioManagement.MarketData.Ticker

  
  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)
  

  def index(conn, params) do
    case MarketData.paginate_tickers(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Tickers. #{inspect(error)}")
        |> redirect(to: Routes.ticker_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = MarketData.change_ticker(%Ticker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticker" => ticker_params}) do
    case MarketData.create_ticker(ticker_params) do
      {:ok, ticker} ->
        conn
        |> put_flash(:info, "Ticker created successfully.")
        |> redirect(to: Routes.ticker_path(conn, :show, ticker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticker = MarketData.get_ticker!(id)
    render(conn, "show.html", ticker: ticker)
  end

  def edit(conn, %{"id" => id}) do
    ticker = MarketData.get_ticker!(id)
    changeset = MarketData.change_ticker(ticker)
    render(conn, "edit.html", ticker: ticker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticker" => ticker_params}) do
    ticker = MarketData.get_ticker!(id)

    case MarketData.update_ticker(ticker, ticker_params) do
      {:ok, ticker} ->
        conn
        |> put_flash(:info, "Ticker updated successfully.")
        |> redirect(to: Routes.ticker_path(conn, :show, ticker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticker: ticker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticker = MarketData.get_ticker!(id)
    {:ok, _ticker} = MarketData.delete_ticker(ticker)

    conn
    |> put_flash(:info, "Ticker deleted successfully.")
    |> redirect(to: Routes.ticker_path(conn, :index))
  end
end
