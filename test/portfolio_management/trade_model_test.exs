defmodule PortfolioManagement.TradeModelTest do
  use PortfolioManagement.DataCase

  alias PortfolioManagement.TradeModel

  alias PortfolioManagement.TradeModel.Book

  @valid_attrs %{book_type: "some book_type", budget: 120.5, currency_denomination: "some currency_denomination", name: "some name"}
  @update_attrs %{book_type: "some updated book_type", budget: 456.7, currency_denomination: "some updated currency_denomination", name: "some updated name"}
  @invalid_attrs %{book_type: nil, budget: nil, currency_denomination: nil, name: nil}

  describe "#paginate_books/1" do
    test "returns paginated list of books" do
      for _ <- 1..20 do
        book_fixture()
      end

      {:ok, %{books: books} = page} = TradeModel.paginate_books(%{})

      assert length(books) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_books/0" do
    test "returns all books" do
      book = book_fixture()
      assert TradeModel.list_books() == [book]
    end
  end

  describe "#get_book!/1" do
    test "returns the book with given id" do
      book = book_fixture()
      assert TradeModel.get_book!(book.id) == book
    end
  end

  describe "#create_book/1" do
    test "with valid data creates a book" do
      assert {:ok, %Book{} = book} = TradeModel.create_book(@valid_attrs)
      assert book.book_type == "some book_type"
      assert book.budget == 120.5
      assert book.currency_denomination == "some currency_denomination"
      assert book.name == "some name"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TradeModel.create_book(@invalid_attrs)
    end
  end

  describe "#update_book/2" do
    test "with valid data updates the book" do
      book = book_fixture()
      assert {:ok, book} = TradeModel.update_book(book, @update_attrs)
      assert %Book{} = book
      assert book.book_type == "some updated book_type"
      assert book.budget == 456.7
      assert book.currency_denomination == "some updated currency_denomination"
      assert book.name == "some updated name"
    end

    test "with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = TradeModel.update_book(book, @invalid_attrs)
      assert book == TradeModel.get_book!(book.id)
    end
  end

  describe "#delete_book/1" do
    test "deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = TradeModel.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> TradeModel.get_book!(book.id) end
    end
  end

  describe "#change_book/1" do
    test "returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = TradeModel.change_book(book)
    end
  end

  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(@valid_attrs)
      |> TradeModel.create_book()

    book
  end


  alias PortfolioManagement.TradeModel.Portfolio

  @valid_attrs %{budget: 120.5, currency_denomination: "some currency_denomination", name: "some name", portfolio_type: "some portfolio_type"}
  @update_attrs %{budget: 456.7, currency_denomination: "some updated currency_denomination", name: "some updated name", portfolio_type: "some updated portfolio_type"}
  @invalid_attrs %{budget: nil, currency_denomination: nil, name: nil, portfolio_type: nil}

  describe "#paginate_portfolios/1" do
    test "returns paginated list of portfolios" do
      for _ <- 1..20 do
        portfolio_fixture()
      end

      {:ok, %{portfolios: portfolios} = page} = TradeModel.paginate_portfolios(%{})

      assert length(portfolios) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_portfolios/0" do
    test "returns all portfolios" do
      portfolio = portfolio_fixture()
      assert TradeModel.list_portfolios() == [portfolio]
    end
  end

  describe "#get_portfolio!/1" do
    test "returns the portfolio with given id" do
      portfolio = portfolio_fixture()
      assert TradeModel.get_portfolio!(portfolio.id) == portfolio
    end
  end

  describe "#create_portfolio/1" do
    test "with valid data creates a portfolio" do
      assert {:ok, %Portfolio{} = portfolio} = TradeModel.create_portfolio(@valid_attrs)
      assert portfolio.budget == 120.5
      assert portfolio.currency_denomination == "some currency_denomination"
      assert portfolio.name == "some name"
      assert portfolio.portfolio_type == "some portfolio_type"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TradeModel.create_portfolio(@invalid_attrs)
    end
  end

  describe "#update_portfolio/2" do
    test "with valid data updates the portfolio" do
      portfolio = portfolio_fixture()
      assert {:ok, portfolio} = TradeModel.update_portfolio(portfolio, @update_attrs)
      assert %Portfolio{} = portfolio
      assert portfolio.budget == 456.7
      assert portfolio.currency_denomination == "some updated currency_denomination"
      assert portfolio.name == "some updated name"
      assert portfolio.portfolio_type == "some updated portfolio_type"
    end

    test "with invalid data returns error changeset" do
      portfolio = portfolio_fixture()
      assert {:error, %Ecto.Changeset{}} = TradeModel.update_portfolio(portfolio, @invalid_attrs)
      assert portfolio == TradeModel.get_portfolio!(portfolio.id)
    end
  end

  describe "#delete_portfolio/1" do
    test "deletes the portfolio" do
      portfolio = portfolio_fixture()
      assert {:ok, %Portfolio{}} = TradeModel.delete_portfolio(portfolio)
      assert_raise Ecto.NoResultsError, fn -> TradeModel.get_portfolio!(portfolio.id) end
    end
  end

  describe "#change_portfolio/1" do
    test "returns a portfolio changeset" do
      portfolio = portfolio_fixture()
      assert %Ecto.Changeset{} = TradeModel.change_portfolio(portfolio)
    end
  end

  def portfolio_fixture(attrs \\ %{}) do
    {:ok, portfolio} =
      attrs
      |> Enum.into(@valid_attrs)
      |> TradeModel.create_portfolio()

    portfolio
  end

end
