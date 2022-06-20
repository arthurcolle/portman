defmodule PortfolioManagementWeb.OptionControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.MarketData

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:option) do
    {:ok, option} = MarketData.create_option(@create_attrs)
    option
  end

  describe "index" do
    test "lists all options", %{conn: conn} do
      conn = get conn, Routes.option_path(conn, :index)
      assert html_response(conn, 200) =~ "Options"
    end
  end

  describe "new option" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.option_path(conn, :new)
      assert html_response(conn, 200) =~ "New Option"
    end
  end

  describe "create option" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.option_path(conn, :create), option: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.option_path(conn, :show, id)

      conn = get conn, Routes.option_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Option Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.option_path(conn, :create), option: @invalid_attrs
      assert html_response(conn, 200) =~ "New Option"
    end
  end

  describe "edit option" do
    setup [:create_option]

    test "renders form for editing chosen option", %{conn: conn, option: option} do
      conn = get conn, Routes.option_path(conn, :edit, option)
      assert html_response(conn, 200) =~ "Edit Option"
    end
  end

  describe "update option" do
    setup [:create_option]

    test "redirects when data is valid", %{conn: conn, option: option} do
      conn = put conn, Routes.option_path(conn, :update, option), option: @update_attrs
      assert redirected_to(conn) == Routes.option_path(conn, :show, option)

      conn = get conn, Routes.option_path(conn, :show, option)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, option: option} do
      conn = put conn, Routes.option_path(conn, :update, option), option: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Option"
    end
  end

  describe "delete option" do
    setup [:create_option]

    test "deletes chosen option", %{conn: conn, option: option} do
      conn = delete conn, Routes.option_path(conn, :delete, option)
      assert redirected_to(conn) == Routes.option_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.option_path(conn, :show, option)
      end
    end
  end

  defp create_option(_) do
    option = fixture(:option)
    {:ok, option: option}
  end
end
