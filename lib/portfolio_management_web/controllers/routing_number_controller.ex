defmodule PortfolioManagementWeb.RoutingNumberController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.Ledger
  alias PortfolioManagement.BankingInformation
  alias PortfolioManagement.BankingInformation.RoutingNumber


  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)


  def index(conn, params) do
    case BankingInformation.paginate_routing_numbers(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Routing numbers. #{inspect(error)}")
        |> redirect(to: Routes.routing_number_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = BankingInformation.change_routing_number(%RoutingNumber{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"routing_number" => routing_number_params}) do
    case BankingInformation.create_routing_number(routing_number_params) do
      {:ok, routing_number} ->
        conn
        |> put_flash(:info, "Routing number created successfully.")
        |> redirect(to: Routes.routing_number_path(conn, :show, routing_number))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    routing_number = BankingInformation.get_routing_number!(id)
    account = BankingInformation.get_account_for_routing_number!(id)
    formatted_routing_number =
      routing_number.value
      |> String.to_charlist
      |> Enum.chunk_every(4)
      |> Enum.join(" ")
    render(conn, "show.html", routing_number: routing_number, formatted_routing_number: formatted_routing_number, account_name: account.name)
  end

  def edit(conn, %{"id" => id}) do
    routing_number = BankingInformation.get_routing_number!(id)
    changeset = BankingInformation.change_routing_number(routing_number)
    account = Ledger.get_account!(routing_number.account_id)
    accounts = Ledger.list_accounts
    render(conn, "edit.html", routing_number: routing_number, account: account, accounts: accounts, changeset: changeset)
  end

  def update(conn, %{"id" => id, "routing_number" => routing_number_params}) do
    routing_number = BankingInformation.get_routing_number!(id)

    case BankingInformation.update_routing_number(routing_number, routing_number_params) do
      {:ok, routing_number} ->
        conn
        |> put_flash(:info, "Routing number updated successfully.")
        |> redirect(to: Routes.routing_number_path(conn, :show, routing_number))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", routing_number: routing_number, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    routing_number = BankingInformation.get_routing_number!(id)
    {:ok, _routing_number} = BankingInformation.delete_routing_number(routing_number)

    conn
    |> put_flash(:info, "Routing number deleted successfully.")
    |> redirect(to: Routes.routing_number_path(conn, :index))
  end
end
