defmodule BalderdashWeb.PageController do
  use BalderdashWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
