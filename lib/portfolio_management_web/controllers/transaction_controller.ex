defmodule PortfolioManagementWeb.TransactionController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.Ledger
  alias PortfolioManagement.Ledger.Transaction

  
  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)
  

  def index(conn, params) do
    case Ledger.paginate_transactions(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Transactions. #{inspect(error)}")
        |> redirect(to: Routes.transaction_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Ledger.change_transaction(%Transaction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    case Ledger.create_transaction(transaction_params) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Ledger.get_transaction!(id)
    render(conn, "show.html", transaction: transaction)
  end

  def edit(conn, %{"id" => id}) do
    transaction = Ledger.get_transaction!(id)
    changeset = Ledger.change_transaction(transaction)
    render(conn, "edit.html", transaction: transaction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Ledger.get_transaction!(id)

    case Ledger.update_transaction(transaction, transaction_params) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction updated successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transaction: transaction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Ledger.get_transaction!(id)
    {:ok, _transaction} = Ledger.delete_transaction(transaction)

    conn
    |> put_flash(:info, "Transaction deleted successfully.")
    |> redirect(to: Routes.transaction_path(conn, :index))
  end
end
