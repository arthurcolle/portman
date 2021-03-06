defmodule PortfolioManagement.MarketDataTest do
  use PortfolioManagement.DataCase

  alias PortfolioManagement.MarketData

  alias PortfolioManagement.MarketData.Ticker

  @valid_attrs %{description: "some description", exchange: "some exchange", security_type: "some security_type", symbol: "some symbol"}
  @update_attrs %{description: "some updated description", exchange: "some updated exchange", security_type: "some updated security_type", symbol: "some updated symbol"}
  @invalid_attrs %{description: nil, exchange: nil, security_type: nil, symbol: nil}

  describe "#paginate_tickers/1" do
    test "returns paginated list of tickers" do
      for _ <- 1..20 do
        ticker_fixture()
      end

      {:ok, %{tickers: tickers} = page} = MarketData.paginate_tickers(%{})

      assert length(tickers) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_tickers/0" do
    test "returns all tickers" do
      ticker = ticker_fixture()
      assert MarketData.list_tickers() == [ticker]
    end
  end

  describe "#get_ticker!/1" do
    test "returns the ticker with given id" do
      ticker = ticker_fixture()
      assert MarketData.get_ticker!(ticker.id) == ticker
    end
  end

  describe "#create_ticker/1" do
    test "with valid data creates a ticker" do
      assert {:ok, %Ticker{} = ticker} = MarketData.create_ticker(@valid_attrs)
      assert ticker.description == "some description"
      assert ticker.exchange == "some exchange"
      assert ticker.security_type == "some security_type"
      assert ticker.symbol == "some symbol"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MarketData.create_ticker(@invalid_attrs)
    end
  end

  describe "#update_ticker/2" do
    test "with valid data updates the ticker" do
      ticker = ticker_fixture()
      assert {:ok, ticker} = MarketData.update_ticker(ticker, @update_attrs)
      assert %Ticker{} = ticker
      assert ticker.description == "some updated description"
      assert ticker.exchange == "some updated exchange"
      assert ticker.security_type == "some updated security_type"
      assert ticker.symbol == "some updated symbol"
    end

    test "with invalid data returns error changeset" do
      ticker = ticker_fixture()
      assert {:error, %Ecto.Changeset{}} = MarketData.update_ticker(ticker, @invalid_attrs)
      assert ticker == MarketData.get_ticker!(ticker.id)
    end
  end

  describe "#delete_ticker/1" do
    test "deletes the ticker" do
      ticker = ticker_fixture()
      assert {:ok, %Ticker{}} = MarketData.delete_ticker(ticker)
      assert_raise Ecto.NoResultsError, fn -> MarketData.get_ticker!(ticker.id) end
    end
  end

  describe "#change_ticker/1" do
    test "returns a ticker changeset" do
      ticker = ticker_fixture()
      assert %Ecto.Changeset{} = MarketData.change_ticker(ticker)
    end
  end

  def ticker_fixture(attrs \\ %{}) do
    {:ok, ticker} =
      attrs
      |> Enum.into(@valid_attrs)
      |> MarketData.create_ticker()

    ticker
  end


  alias PortfolioManagement.MarketData.Option

  @valid_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "#paginate_options/1" do
    test "returns paginated list of options" do
      for _ <- 1..20 do
        option_fixture()
      end

      {:ok, %{options: options} = page} = MarketData.paginate_options(%{})

      assert length(options) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_options/0" do
    test "returns all options" do
      option = option_fixture()
      assert MarketData.list_options() == [option]
    end
  end

  describe "#get_option!/1" do
    test "returns the option with given id" do
      option = option_fixture()
      assert MarketData.get_option!(option.id) == option
    end
  end

  describe "#create_option/1" do
    test "with valid data creates a option" do
      assert {:ok, %Option{} = option} = MarketData.create_option(@valid_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MarketData.create_option(@invalid_attrs)
    end
  end

  describe "#update_option/2" do
    test "with valid data updates the option" do
      option = option_fixture()
      assert {:ok, option} = MarketData.update_option(option, @update_attrs)
      assert %Option{} = option
    end

    test "with invalid data returns error changeset" do
      option = option_fixture()
      assert {:error, %Ecto.Changeset{}} = MarketData.update_option(option, @invalid_attrs)
      assert option == MarketData.get_option!(option.id)
    end
  end

  describe "#delete_option/1" do
    test "deletes the option" do
      option = option_fixture()
      assert {:ok, %Option{}} = MarketData.delete_option(option)
      assert_raise Ecto.NoResultsError, fn -> MarketData.get_option!(option.id) end
    end
  end

  describe "#change_option/1" do
    test "returns a option changeset" do
      option = option_fixture()
      assert %Ecto.Changeset{} = MarketData.change_option(option)
    end
  end

  def option_fixture(attrs \\ %{}) do
    {:ok, option} =
      attrs
      |> Enum.into(@valid_attrs)
      |> MarketData.create_option()

    option
  end

end
