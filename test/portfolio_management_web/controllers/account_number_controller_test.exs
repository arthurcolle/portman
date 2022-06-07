defmodule PortfolioManagementWeb.AccountNumberControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.BankingInformation

  @create_attrs %{value: "some value"}
  @update_attrs %{value: "some updated value"}
  @invalid_attrs %{value: nil}

  def fixture(:account_number) do
    {:ok, account_number} = BankingInformation.create_account_number(@create_attrs)
    account_number
  end

  describe "index" do
    test "lists all account_numbers", %{conn: conn} do
      conn = get conn, Routes.account_number_path(conn, :index)
      assert html_response(conn, 200) =~ "Account numbers"
    end
  end

  describe "new account_number" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.account_number_path(conn, :new)
      assert html_response(conn, 200) =~ "New Account number"
    end
  end

  describe "create account_number" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.account_number_path(conn, :create), account_number: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.account_number_path(conn, :show, id)

      conn = get conn, Routes.account_number_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Account number Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.account_number_path(conn, :create), account_number: @invalid_attrs
      assert html_response(conn, 200) =~ "New Account number"
    end
  end

  describe "edit account_number" do
    setup [:create_account_number]

    test "renders form for editing chosen account_number", %{conn: conn, account_number: account_number} do
      conn = get conn, Routes.account_number_path(conn, :edit, account_number)
      assert html_response(conn, 200) =~ "Edit Account number"
    end
  end

  describe "update account_number" do
    setup [:create_account_number]

    test "redirects when data is valid", %{conn: conn, account_number: account_number} do
      conn = put conn, Routes.account_number_path(conn, :update, account_number), account_number: @update_attrs
      assert redirected_to(conn) == Routes.account_number_path(conn, :show, account_number)

      conn = get conn, Routes.account_number_path(conn, :show, account_number)
      assert html_response(conn, 200) =~ "some updated value"
    end

    test "renders errors when data is invalid", %{conn: conn, account_number: account_number} do
      conn = put conn, Routes.account_number_path(conn, :update, account_number), account_number: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Account number"
    end
  end

  describe "delete account_number" do
    setup [:create_account_number]

    test "deletes chosen account_number", %{conn: conn, account_number: account_number} do
      conn = delete conn, Routes.account_number_path(conn, :delete, account_number)
      assert redirected_to(conn) == Routes.account_number_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.account_number_path(conn, :show, account_number)
      end
    end
  end

  defp create_account_number(_) do
    account_number = fixture(:account_number)
    {:ok, account_number: account_number}
  end
end
