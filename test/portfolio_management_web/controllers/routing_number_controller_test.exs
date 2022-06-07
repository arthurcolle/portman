defmodule PortfolioManagementWeb.RoutingNumberControllerTest do
  use PortfolioManagementWeb.ConnCase

  alias PortfolioManagement.BankingInformation

  @create_attrs %{value: "some value"}
  @update_attrs %{value: "some updated value"}
  @invalid_attrs %{value: nil}

  def fixture(:routing_number) do
    {:ok, routing_number} = BankingInformation.create_routing_number(@create_attrs)
    routing_number
  end

  describe "index" do
    test "lists all routing_numbers", %{conn: conn} do
      conn = get conn, Routes.routing_number_path(conn, :index)
      assert html_response(conn, 200) =~ "Routing numbers"
    end
  end

  describe "new routing_number" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.routing_number_path(conn, :new)
      assert html_response(conn, 200) =~ "New Routing number"
    end
  end

  describe "create routing_number" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.routing_number_path(conn, :create), routing_number: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.routing_number_path(conn, :show, id)

      conn = get conn, Routes.routing_number_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Routing number Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.routing_number_path(conn, :create), routing_number: @invalid_attrs
      assert html_response(conn, 200) =~ "New Routing number"
    end
  end

  describe "edit routing_number" do
    setup [:create_routing_number]

    test "renders form for editing chosen routing_number", %{conn: conn, routing_number: routing_number} do
      conn = get conn, Routes.routing_number_path(conn, :edit, routing_number)
      assert html_response(conn, 200) =~ "Edit Routing number"
    end
  end

  describe "update routing_number" do
    setup [:create_routing_number]

    test "redirects when data is valid", %{conn: conn, routing_number: routing_number} do
      conn = put conn, Routes.routing_number_path(conn, :update, routing_number), routing_number: @update_attrs
      assert redirected_to(conn) == Routes.routing_number_path(conn, :show, routing_number)

      conn = get conn, Routes.routing_number_path(conn, :show, routing_number)
      assert html_response(conn, 200) =~ "some updated value"
    end

    test "renders errors when data is invalid", %{conn: conn, routing_number: routing_number} do
      conn = put conn, Routes.routing_number_path(conn, :update, routing_number), routing_number: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Routing number"
    end
  end

  describe "delete routing_number" do
    setup [:create_routing_number]

    test "deletes chosen routing_number", %{conn: conn, routing_number: routing_number} do
      conn = delete conn, Routes.routing_number_path(conn, :delete, routing_number)
      assert redirected_to(conn) == Routes.routing_number_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.routing_number_path(conn, :show, routing_number)
      end
    end
  end

  defp create_routing_number(_) do
    routing_number = fixture(:routing_number)
    {:ok, routing_number: routing_number}
  end
end
