defmodule PortfolioManagementWeb.AccountControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.Ledger

  @create_attrs %{balance: 120.5, currency_denomination: "some currency_denomination", description: "some description", name: "some name"}
  @update_attrs %{balance: 456.7, currency_denomination: "some updated currency_denomination", description: "some updated description", name: "some updated name"}
  @invalid_attrs %{balance: nil, currency_denomination: nil, description: nil, name: nil}

  def fixture(:account) do
    {:ok, account} = Ledger.create_account(@create_attrs)
    account
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get conn, Routes.account_path(conn, :index)
      assert html_response(conn, 200) =~ "Accounts"
    end
  end

  describe "new account" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.account_path(conn, :new)
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "create account" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.account_path(conn, :create), account: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.account_path(conn, :show, id)

      conn = get conn, Routes.account_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Account Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.account_path(conn, :create), account: @invalid_attrs
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    test "renders form for editing chosen account", %{conn: conn, account: account} do
      conn = get conn, Routes.account_path(conn, :edit, account)
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "update account" do
    setup [:create_account]

    test "redirects when data is valid", %{conn: conn, account: account} do
      conn = put conn, Routes.account_path(conn, :update, account), account: @update_attrs
      assert redirected_to(conn) == Routes.account_path(conn, :show, account)

      conn = get conn, Routes.account_path(conn, :show, account)
      assert html_response(conn, 200) =~ "some updated currency_denomination"
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put conn, Routes.account_path(conn, :update, account), account: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete conn, Routes.account_path(conn, :delete, account)
      assert redirected_to(conn) == Routes.account_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.account_path(conn, :show, account)
      end
    end
  end

  defp create_account(_) do
    account = fixture(:account)
    {:ok, account: account}
  end
end
