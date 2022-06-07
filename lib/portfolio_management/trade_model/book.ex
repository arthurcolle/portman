defmodule PortfolioManagement.TradeModel.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :book_type, :string
    field :budget, :float
    field :currency_denomination, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:book_type, :name, :budget, :currency_denomination])
    |> validate_required([:book_type, :name, :budget, :currency_denomination])
  end
end
