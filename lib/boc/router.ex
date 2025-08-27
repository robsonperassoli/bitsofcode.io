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
        send_resp(conn, 200, render_template(article))
    end
  end

  defp render_template(article) do
    """
    <html>
    <head>
      <title>#{article.meta["title"]}</title>

      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Libertinus+Serif+Display&family=Mona+Sans:ital,wght@0,200..900;1,200..900&display=swap" rel="stylesheet">

      <link href="/public/styles.css" rel="stylesheet">

    </head>
    <body>
      <div class="markdown">
        #{article.html}
      </div>
    </body>
    </html>
    """
  end
end
