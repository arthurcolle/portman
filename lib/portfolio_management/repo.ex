defmodule PortfolioManagement.Repo do
  use Ecto.Repo,
    otp_app: :portfolio_management,
    adapter: Ecto.Adapters.Postgres
end
