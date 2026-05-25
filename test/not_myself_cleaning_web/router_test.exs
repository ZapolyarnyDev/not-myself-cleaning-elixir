defmodule NotMyselfCleaningWeb.RouterTest do
  use ExUnit.Case, async: true
  import Plug.Conn
  import Plug.Test

  @opts NotMyselfCleaningWeb.Endpoint.init([])

  test "redirects the home page to login" do
    conn =
      :get
      |> conn("/")
      |> NotMyselfCleaningWeb.Endpoint.call(@opts)

    assert conn.status == 302
    assert get_resp_header(conn, "location") == ["/login"]
  end

  test "returns health status" do
    conn =
      :get
      |> conn("/health")
      |> NotMyselfCleaningWeb.Endpoint.call(@opts)

    assert conn.status == 200
    assert Jason.decode!(conn.resp_body) == %{"status" => "ok"}
  end
end
