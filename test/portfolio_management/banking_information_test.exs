defmodule PortfolioManagement.BankingInformationTest do
  use PortfolioManagement.DataCase

  alias PortfolioManagement.BankingInformation

  alias PortfolioManagement.BankingInformation.RoutingNumber

  @valid_attrs %{value: "some value"}
  @update_attrs %{value: "some updated value"}
  @invalid_attrs %{value: nil}

  describe "#paginate_routing_numbers/1" do
    test "returns paginated list of routing_numbers" do
      for _ <- 1..20 do
        routing_number_fixture()
      end

      {:ok, %{routing_numbers: routing_numbers} = page} = BankingInformation.paginate_routing_numbers(%{})

      assert length(routing_numbers) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_routing_numbers/0" do
    test "returns all routing_numbers" do
      routing_number = routing_number_fixture()
      assert BankingInformation.list_routing_numbers() == [routing_number]
    end
  end

  describe "#get_routing_number!/1" do
    test "returns the routing_number with given id" do
      routing_number = routing_number_fixture()
      assert BankingInformation.get_routing_number!(routing_number.id) == routing_number
    end
  end

  describe "#create_routing_number/1" do
    test "with valid data creates a routing_number" do
      assert {:ok, %RoutingNumber{} = routing_number} = BankingInformation.create_routing_number(@valid_attrs)
      assert routing_number.value == "some value"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BankingInformation.create_routing_number(@invalid_attrs)
    end
  end

  describe "#update_routing_number/2" do
    test "with valid data updates the routing_number" do
      routing_number = routing_number_fixture()
      assert {:ok, routing_number} = BankingInformation.update_routing_number(routing_number, @update_attrs)
      assert %RoutingNumber{} = routing_number
      assert routing_number.value == "some updated value"
    end

    test "with invalid data returns error changeset" do
      routing_number = routing_number_fixture()
      assert {:error, %Ecto.Changeset{}} = BankingInformation.update_routing_number(routing_number, @invalid_attrs)
      assert routing_number == BankingInformation.get_routing_number!(routing_number.id)
    end
  end

  describe "#delete_routing_number/1" do
    test "deletes the routing_number" do
      routing_number = routing_number_fixture()
      assert {:ok, %RoutingNumber{}} = BankingInformation.delete_routing_number(routing_number)
      assert_raise Ecto.NoResultsError, fn -> BankingInformation.get_routing_number!(routing_number.id) end
    end
  end

  describe "#change_routing_number/1" do
    test "returns a routing_number changeset" do
      routing_number = routing_number_fixture()
      assert %Ecto.Changeset{} = BankingInformation.change_routing_number(routing_number)
    end
  end

  def routing_number_fixture(attrs \\ %{}) do
    {:ok, routing_number} =
      attrs
      |> Enum.into(@valid_attrs)
      |> BankingInformation.create_routing_number()

    routing_number
  end


  alias PortfolioManagement.BankingInformation.AccountNumber

  @valid_attrs %{value: "some value"}
  @update_attrs %{value: "some updated value"}
  @invalid_attrs %{value: nil}

  describe "#paginate_account_numbers/1" do
    test "returns paginated list of account_numbers" do
      for _ <- 1..20 do
        account_number_fixture()
      end

      {:ok, %{account_numbers: account_numbers} = page} = BankingInformation.paginate_account_numbers(%{})

      assert length(account_numbers) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_account_numbers/0" do
    test "returns all account_numbers" do
      account_number = account_number_fixture()
      assert BankingInformation.list_account_numbers() == [account_number]
    end
  end

  describe "#get_account_number!/1" do
    test "returns the account_number with given id" do
      account_number = account_number_fixture()
      assert BankingInformation.get_account_number!(account_number.id) == account_number
    end
  end

  describe "#create_account_number/1" do
    test "with valid data creates a account_number" do
      assert {:ok, %AccountNumber{} = account_number} = BankingInformation.create_account_number(@valid_attrs)
      assert account_number.value == "some value"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BankingInformation.create_account_number(@invalid_attrs)
    end
  end

  describe "#update_account_number/2" do
    test "with valid data updates the account_number" do
      account_number = account_number_fixture()
      assert {:ok, account_number} = BankingInformation.update_account_number(account_number, @update_attrs)
      assert %AccountNumber{} = account_number
      assert account_number.value == "some updated value"
    end

    test "with invalid data returns error changeset" do
      account_number = account_number_fixture()
      assert {:error, %Ecto.Changeset{}} = BankingInformation.update_account_number(account_number, @invalid_attrs)
      assert account_number == BankingInformation.get_account_number!(account_number.id)
    end
  end

  describe "#delete_account_number/1" do
    test "deletes the account_number" do
      account_number = account_number_fixture()
      assert {:ok, %AccountNumber{}} = BankingInformation.delete_account_number(account_number)
      assert_raise Ecto.NoResultsError, fn -> BankingInformation.get_account_number!(account_number.id) end
    end
  end

  describe "#change_account_number/1" do
    test "returns a account_number changeset" do
      account_number = account_number_fixture()
      assert %Ecto.Changeset{} = BankingInformation.change_account_number(account_number)
    end
  end

  def account_number_fixture(attrs \\ %{}) do
    {:ok, account_number} =
      attrs
      |> Enum.into(@valid_attrs)
      |> BankingInformation.create_account_number()

    account_number
  end

end
