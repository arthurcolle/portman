defmodule PortfolioManagementWeb.PageController do
  use PortfolioManagementWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
