defmodule PortfolioManagementWeb.OptionController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.MarketData
  alias PortfolioManagement.MarketData.Option


  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)


  def index(conn, params) do
    case MarketData.paginate_options(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Options. #{inspect(error)}")
        |> redirect(to: Routes.option_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = MarketData.change_option(%Option{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"option" => option_params}) do
    case MarketData.create_option(option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option created successfully.")
        |> redirect(to: Routes.option_path(conn, :show, option))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option = MarketData.get_option!(id)
    render(conn, "show.html", option: option)
  end

  def edit(conn, %{"id" => id}) do
    option = MarketData.get_option!(id)
    changeset = MarketData.change_option(option)
    render(conn, "edit.html", option: option, changeset: changeset)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = MarketData.get_option!(id)
    case MarketData.update_option(option, option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option updated successfully.")
        |> redirect(to: Routes.option_path(conn, :show, option))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", option: option, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = MarketData.get_option!(id)
    {:ok, _option} = MarketData.delete_option(option)

    conn
    |> put_flash(:info, "Option deleted successfully.")
    |> redirect(to: Routes.option_path(conn, :index))
  end
end
