defmodule PortfolioManagementWeb.BookController do
  use PortfolioManagementWeb, :controller

  alias PortfolioManagement.TradeModel
  alias PortfolioManagement.TradeModel.Book


  plug(:put_root_layout, {PortfolioManagementWeb.LayoutView, "torch.html"})
  plug(:put_layout, false)


  def index(conn, params) do
    case TradeModel.paginate_books(params) do
      {:ok, assigns} ->
        Kernel.update_in(assigns.books, [:budget], fn(b) -> :erlang.float_to_binary(b, decimals: 2) end)
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Books. #{inspect(error)}")
        |> redirect(to: Routes.book_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = TradeModel.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case TradeModel.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = TradeModel.get_book!(id)
    formatted_budget =
      book.budget
      |> :erlang.float_to_binary(decimals: 2)
    render(conn, "show.html", formatted_budget: formatted_budget, book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = TradeModel.get_book!(id)
    changeset = TradeModel.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = TradeModel.get_book!(id)

    case TradeModel.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = TradeModel.get_book!(id)
    {:ok, _book} = TradeModel.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end
end
