defmodule PortfolioManagementWeb.PortfolioController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.TradeModel
  alias PortfolioManagement.TradeModel.Portfolio

  
  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)
  

  def index(conn, params) do
    case TradeModel.paginate_portfolios(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Portfolios. #{inspect(error)}")
        |> redirect(to: Routes.portfolio_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = TradeModel.change_portfolio(%Portfolio{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"portfolio" => portfolio_params}) do
    case TradeModel.create_portfolio(portfolio_params) do
      {:ok, portfolio} ->
        conn
        |> put_flash(:info, "Portfolio created successfully.")
        |> redirect(to: Routes.portfolio_path(conn, :show, portfolio))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    portfolio = TradeModel.get_portfolio!(id)
    render(conn, "show.html", portfolio: portfolio)
  end

  def edit(conn, %{"id" => id}) do
    portfolio = TradeModel.get_portfolio!(id)
    changeset = TradeModel.change_portfolio(portfolio)
    render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
  end

  def update(conn, %{"id" => id, "portfolio" => portfolio_params}) do
    portfolio = TradeModel.get_portfolio!(id)

    case TradeModel.update_portfolio(portfolio, portfolio_params) do
      {:ok, portfolio} ->
        conn
        |> put_flash(:info, "Portfolio updated successfully.")
        |> redirect(to: Routes.portfolio_path(conn, :show, portfolio))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    portfolio = TradeModel.get_portfolio!(id)
    {:ok, _portfolio} = TradeModel.delete_portfolio(portfolio)

    conn
    |> put_flash(:info, "Portfolio deleted successfully.")
    |> redirect(to: Routes.portfolio_path(conn, :index))
  end
end
