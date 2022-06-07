defmodule PortfolioManagementWeb.BookControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.TradeModel

  @create_attrs %{book_type: "some book_type", budget: 120.5, currency_denomination: "some currency_denomination", name: "some name"}
  @update_attrs %{book_type: "some updated book_type", budget: 456.7, currency_denomination: "some updated currency_denomination", name: "some updated name"}
  @invalid_attrs %{book_type: nil, budget: nil, currency_denomination: nil, name: nil}

  def fixture(:book) do
    {:ok, book} = TradeModel.create_book(@create_attrs)
    book
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get conn, Routes.book_path(conn, :index)
      assert html_response(conn, 200) =~ "Books"
    end
  end

  describe "new book" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.book_path(conn, :new)
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "create book" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.book_path(conn, :create), book: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.book_path(conn, :show, id)

      conn = get conn, Routes.book_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Book Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.book_path(conn, :create), book: @invalid_attrs
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "edit book" do
    setup [:create_book]

    test "renders form for editing chosen book", %{conn: conn, book: book} do
      conn = get conn, Routes.book_path(conn, :edit, book)
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "update book" do
    setup [:create_book]

    test "redirects when data is valid", %{conn: conn, book: book} do
      conn = put conn, Routes.book_path(conn, :update, book), book: @update_attrs
      assert redirected_to(conn) == Routes.book_path(conn, :show, book)

      conn = get conn, Routes.book_path(conn, :show, book)
      assert html_response(conn, 200) =~ "some updated book_type"
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put conn, Routes.book_path(conn, :update, book), book: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete conn, Routes.book_path(conn, :delete, book)
      assert redirected_to(conn) == Routes.book_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.book_path(conn, :show, book)
      end
    end
  end

  defp create_book(_) do
    book = fixture(:book)
    {:ok, book: book}
  end
end