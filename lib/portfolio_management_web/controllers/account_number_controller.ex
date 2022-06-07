defmodule PortfolioManagementWeb.AccountNumberController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.BankingInformation
  alias PortfolioManagement.BankingInformation.AccountNumber
  alias PortfolioManagement.Ledger.Account
  alias PortfolioManagement.Repo



  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)


  def index(conn, params) do
    case BankingInformation.paginate_account_numbers(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Account numbers. #{inspect(error)}")
        |> redirect(to: Routes.account_number_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = BankingInformation.change_account_number(%AccountNumber{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account_number" => account_number_params}) do
    case BankingInformation.create_account_number(account_number_params) do
      {:ok, account_number} ->
        conn
        |> put_flash(:info, "Account number created successfully.")
        |> redirect(to: Routes.account_number_path(conn, :show, account_number))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account_number = BankingInformation.get_account_number!(id)
    IO.puts account_number.value
    account = BankingInformation.get_account_for_account_number!(account_number.id)
    IO.puts account.name
    render(conn, "show.html", account_number: account_number, account_name: account.name)
  end

  def edit(conn, %{"id" => id}) do
    account_number = BankingInformation.get_account_number!(id)
    changeset = BankingInformation.change_account_number(account_number)
    render(conn, "edit.html", account_number: account_number, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account_number" => account_number_params}) do
    account_number = BankingInformation.get_account_number!(id)

    case BankingInformation.update_account_number(account_number, account_number_params) do
      {:ok, account_number} ->
        conn
        |> put_flash(:info, "Account number updated successfully.")
        |> redirect(to: Routes.account_number_path(conn, :show, account_number))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", account_number: account_number, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account_number = BankingInformation.get_account_number!(id)
    {:ok, _account_number} = BankingInformation.delete_account_number(account_number)

    conn
    |> put_flash(:info, "Account number deleted successfully.")
    |> redirect(to: Routes.account_number_path(conn, :index))
  end
end
