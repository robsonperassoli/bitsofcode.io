defmodule Boc.RouterTest do
  use ExUnit.Case, async: true

  import Plug.Test
  # import Plug.Conn

  test "/ returns hello world" do
    conn =
      conn(:get, "/")
      |> Boc.Router.call([])

    assert conn.status === 200
    assert conn.resp_body === "hello world!"
  end

  test "unmatched route returns 404" do
    conn =
      conn(:get, "/does-not-exist")
      |> Boc.Router.call([])

    assert conn.status === 404
    assert conn.resp_body === "not found"
  end
end
