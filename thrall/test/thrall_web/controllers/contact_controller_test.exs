defmodule ThrallWeb.ContactControllerTest do
  use ThrallWeb.ConnCase

  test "GET /contact", %{conn: conn} do
    conn = get(conn, "/contact")
    assert html_response(conn, 200) =~ "Contact"
  end
end
