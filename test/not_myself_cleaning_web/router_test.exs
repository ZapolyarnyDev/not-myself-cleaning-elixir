defmodule NotMyselfCleaningWeb.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts NotMyselfCleaningWeb.Router.init([])

  test "renders the home page" do
    conn =
      :get
      |> conn("/")
      |> NotMyselfCleaningWeb.Router.call(@opts)

    assert conn.status == 200
    assert conn.resp_body =~ "Not Myself Cleaning"
  end

  test "returns health status" do
    conn =
      :get
      |> conn("/health")
      |> NotMyselfCleaningWeb.Router.call(@opts)

    assert conn.status == 200
    assert Jason.decode!(conn.resp_body) == %{"status" => "ok"}
  end
end
