defmodule PortfolioManagementWeb.PortfolioControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.TradeModel

  @create_attrs %{budget: 120.5, currency_denomination: "some currency_denomination", name: "some name", portfolio_type: "some portfolio_type"}
  @update_attrs %{budget: 456.7, currency_denomination: "some updated currency_denomination", name: "some updated name", portfolio_type: "some updated portfolio_type"}
  @invalid_attrs %{budget: nil, currency_denomination: nil, name: nil, portfolio_type: nil}

  def fixture(:portfolio) do
    {:ok, portfolio} = TradeModel.create_portfolio(@create_attrs)
    portfolio
  end

  describe "index" do
    test "lists all portfolios", %{conn: conn} do
      conn = get conn, Routes.portfolio_path(conn, :index)
      assert html_response(conn, 200) =~ "Portfolios"
    end
  end

  describe "new portfolio" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.portfolio_path(conn, :new)
      assert html_response(conn, 200) =~ "New Portfolio"
    end
  end

  describe "create portfolio" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.portfolio_path(conn, :create), portfolio: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.portfolio_path(conn, :show, id)

      conn = get conn, Routes.portfolio_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Portfolio Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.portfolio_path(conn, :create), portfolio: @invalid_attrs
      assert html_response(conn, 200) =~ "New Portfolio"
    end
  end

  describe "edit portfolio" do
    setup [:create_portfolio]

    test "renders form for editing chosen portfolio", %{conn: conn, portfolio: portfolio} do
      conn = get conn, Routes.portfolio_path(conn, :edit, portfolio)
      assert html_response(conn, 200) =~ "Edit Portfolio"
    end
  end

  describe "update portfolio" do
    setup [:create_portfolio]

    test "redirects when data is valid", %{conn: conn, portfolio: portfolio} do
      conn = put conn, Routes.portfolio_path(conn, :update, portfolio), portfolio: @update_attrs
      assert redirected_to(conn) == Routes.portfolio_path(conn, :show, portfolio)

      conn = get conn, Routes.portfolio_path(conn, :show, portfolio)
      assert html_response(conn, 200) =~ "some updated currency_denomination"
    end

    test "renders errors when data is invalid", %{conn: conn, portfolio: portfolio} do
      conn = put conn, Routes.portfolio_path(conn, :update, portfolio), portfolio: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Portfolio"
    end
  end

  describe "delete portfolio" do
    setup [:create_portfolio]

    test "deletes chosen portfolio", %{conn: conn, portfolio: portfolio} do
      conn = delete conn, Routes.portfolio_path(conn, :delete, portfolio)
      assert redirected_to(conn) == Routes.portfolio_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.portfolio_path(conn, :show, portfolio)
      end
    end
  end

  defp create_portfolio(_) do
    portfolio = fixture(:portfolio)
    {:ok, portfolio: portfolio}
  end
end
