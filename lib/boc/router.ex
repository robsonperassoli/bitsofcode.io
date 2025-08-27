defmodule Boc.Router do
  use Plug.Router

  plug(Plug.Static,
    at: "/public",
    from: :boc
  )

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    render_article(conn, "home")
  end

  get "/:key" do
    render_article(conn, key)
  end

  match _ do
    not_found(conn)
  end

  defp not_found(conn) do
    send_resp(conn, 404, "not found")
  end

  defp render_article(conn, key) do
    case Boc.Articles.DB.get_article(key) do
      nil ->
        not_found(conn)

      article ->
        send_resp(conn, 200, Boc.Layout.render(article))
    end
  end
end
