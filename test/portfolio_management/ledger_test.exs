defmodule PortfolioManagement.LedgerTest do
  use PortfolioManagement.DataCase

  alias PortfolioManagement.Ledger

  alias PortfolioManagement.Ledger.Account

  @valid_attrs %{balance: 120.5, currency_denomination: "some currency_denomination", description: "some description", name: "some name"}
  @update_attrs %{balance: 456.7, currency_denomination: "some updated currency_denomination", description: "some updated description", name: "some updated name"}
  @invalid_attrs %{balance: nil, currency_denomination: nil, description: nil, name: nil}

  describe "#paginate_accounts/1" do
    test "returns paginated list of accounts" do
      for _ <- 1..20 do
        account_fixture()
      end

      {:ok, %{accounts: accounts} = page} = Ledger.paginate_accounts(%{})

      assert length(accounts) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_accounts/0" do
    test "returns all accounts" do
      account = account_fixture()
      assert Ledger.list_accounts() == [account]
    end
  end

  describe "#get_account!/1" do
    test "returns the account with given id" do
      account = account_fixture()
      assert Ledger.get_account!(account.id) == account
    end
  end

  describe "#create_account/1" do
    test "with valid data creates a account" do
      assert {:ok, %Account{} = account} = Ledger.create_account(@valid_attrs)
      assert account.balance == 120.5
      assert account.currency_denomination == "some currency_denomination"
      assert account.description == "some description"
      assert account.name == "some name"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_account(@invalid_attrs)
    end
  end

  describe "#update_account/2" do
    test "with valid data updates the account" do
      account = account_fixture()
      assert {:ok, account} = Ledger.update_account(account, @update_attrs)
      assert %Account{} = account
      assert account.balance == 456.7
      assert account.currency_denomination == "some updated currency_denomination"
      assert account.description == "some updated description"
      assert account.name == "some updated name"
    end

    test "with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Ledger.update_account(account, @invalid_attrs)
      assert account == Ledger.get_account!(account.id)
    end
  end

  describe "#delete_account/1" do
    test "deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Ledger.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_account!(account.id) end
    end
  end

  describe "#change_account/1" do
    test "returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Ledger.change_account(account)
    end
  end

  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Ledger.create_account()

    account
  end


  alias PortfolioManagement.Ledger.Transaction

  @valid_attrs %{amount: 120.5, executed_at: ~N[2022-06-04 20:40:00], note: "some note", recurring: true, settled_at: ~N[2022-06-04 20:40:00], transaction_type: "some transaction_type"}
  @update_attrs %{amount: 456.7, executed_at: ~N[2022-06-05 20:40:00], note: "some updated note", recurring: false, settled_at: ~N[2022-06-05 20:40:00], transaction_type: "some updated transaction_type"}
  @invalid_attrs %{amount: nil, executed_at: nil, note: nil, recurring: nil, settled_at: nil, transaction_type: nil}

  describe "#paginate_transactions/1" do
    test "returns paginated list of transactions" do
      for _ <- 1..20 do
        transaction_fixture()
      end

      {:ok, %{transactions: transactions} = page} = Ledger.paginate_transactions(%{})

      assert length(transactions) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_transactions/0" do
    test "returns all transactions" do
      transaction = transaction_fixture()
      assert Ledger.list_transactions() == [transaction]
    end
  end

  describe "#get_transaction!/1" do
    test "returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Ledger.get_transaction!(transaction.id) == transaction
    end
  end

  describe "#create_transaction/1" do
    test "with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Ledger.create_transaction(@valid_attrs)
      assert transaction.amount == 120.5
      assert transaction.executed_at == ~N[2022-06-04 20:40:00]
      assert transaction.note == "some note"
      assert transaction.recurring == true
      assert transaction.settled_at == ~N[2022-06-04 20:40:00]
      assert transaction.transaction_type == "some transaction_type"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ledger.create_transaction(@invalid_attrs)
    end
  end

  describe "#update_transaction/2" do
    test "with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, transaction} = Ledger.update_transaction(transaction, @update_attrs)
      assert %Transaction{} = transaction
      assert transaction.amount == 456.7
      assert transaction.executed_at == ~N[2022-06-05 20:40:00]
      assert transaction.note == "some updated note"
      assert transaction.recurring == false
      assert transaction.settled_at == ~N[2022-06-05 20:40:00]
      assert transaction.transaction_type == "some updated transaction_type"
    end

    test "with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Ledger.update_transaction(transaction, @invalid_attrs)
      assert transaction == Ledger.get_transaction!(transaction.id)
    end
  end

  describe "#delete_transaction/1" do
    test "deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Ledger.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Ledger.get_transaction!(transaction.id) end
    end
  end

  describe "#change_transaction/1" do
    test "returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Ledger.change_transaction(transaction)
    end
  end

  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Ledger.create_transaction()

    transaction
  end

end
