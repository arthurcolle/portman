defmodule PortfolioManagementWeb.TickerControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.MarketData

  @create_attrs %{description: "some description", exchange: "some exchange", security_type: "some security_type", symbol: "some symbol"}
  @update_attrs %{description: "some updated description", exchange: "some updated exchange", security_type: "some updated security_type", symbol: "some updated symbol"}
  @invalid_attrs %{description: nil, exchange: nil, security_type: nil, symbol: nil}

  def fixture(:ticker) do
    {:ok, ticker} = MarketData.create_ticker(@create_attrs)
    ticker
  end

  describe "index" do
    test "lists all tickers", %{conn: conn} do
      conn = get conn, Routes.ticker_path(conn, :index)
      assert html_response(conn, 200) =~ "Tickers"
    end
  end

  describe "new ticker" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.ticker_path(conn, :new)
      assert html_response(conn, 200) =~ "New Ticker"
    end
  end

  describe "create ticker" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.ticker_path(conn, :create), ticker: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ticker_path(conn, :show, id)

      conn = get conn, Routes.ticker_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Ticker Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.ticker_path(conn, :create), ticker: @invalid_attrs
      assert html_response(conn, 200) =~ "New Ticker"
    end
  end

  describe "edit ticker" do
    setup [:create_ticker]

    test "renders form for editing chosen ticker", %{conn: conn, ticker: ticker} do
      conn = get conn, Routes.ticker_path(conn, :edit, ticker)
      assert html_response(conn, 200) =~ "Edit Ticker"
    end
  end

  describe "update ticker" do
    setup [:create_ticker]

    test "redirects when data is valid", %{conn: conn, ticker: ticker} do
      conn = put conn, Routes.ticker_path(conn, :update, ticker), ticker: @update_attrs
      assert redirected_to(conn) == Routes.ticker_path(conn, :show, ticker)

      conn = get conn, Routes.ticker_path(conn, :show, ticker)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, ticker: ticker} do
      conn = put conn, Routes.ticker_path(conn, :update, ticker), ticker: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Ticker"
    end
  end

  describe "delete ticker" do
    setup [:create_ticker]

    test "deletes chosen ticker", %{conn: conn, ticker: ticker} do
      conn = delete conn, Routes.ticker_path(conn, :delete, ticker)
      assert redirected_to(conn) == Routes.ticker_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.ticker_path(conn, :show, ticker)
      end
    end
  end

  defp create_ticker(_) do
    ticker = fixture(:ticker)
    {:ok, ticker: ticker}
  end
end
