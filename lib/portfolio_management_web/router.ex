defmodule PortfolioManagementWeb.Router do
  use PortfolioManagementWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PortfolioManagementWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PortfolioManagementWeb do
    pipe_through :browser

    get "/", PageController, :index
    scope "/api" do
      scope "/v1" do

      end
    end

    # Trade Model routes
    resources "/accounts", AccountController
    resources "/routing_numbers", RoutingNumberController
    resources "/account_numbers", AccountNumberController

    resources "/books", BookController
    resources "/portfolios", PortfolioController
    resources "/transactions", TransactionController

    # Market Data routes
    resources "/tickers", TickerController
    # resources "/options", OptionController

  end

  # Other scopes may use custom stacks.
  # scope "/api", PortfolioManagementWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PortfolioManagementWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
