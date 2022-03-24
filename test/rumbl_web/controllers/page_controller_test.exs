defmodule RumblWeb.PageControllerTest do
  use RumblWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    # =~ 文字列を含むか否か
    # https://hexdocs.pm/elixir/Kernel.html#=~/2
    assert html_response(conn, 200) =~ "Welcome to Rumbl.io!"
  end
end
