defmodule Boc.Articles do
  alias Boc.Markdown

  def list_articles() do
    File.ls!(Boc.articles_path())
  end

  def compile_article(file_name) do
    [file_name_no_ext, _] = String.split(file_name, ".")

    {:ok, article} =
      "#{Boc.articles_path()}/#{file_name}"
      |> File.read!()
      |> Markdown.parse()

    article =
      if map_size(article.meta) === 0 do
        Map.put(article, :meta, %{"title" => file_name_to_title(file_name_no_ext)})
      else
        article
      end

    Map.put(article, :key, file_name_no_ext)
  end

  def compile_articles do
    list_articles()
    |> Task.async_stream(__MODULE__, :compile_article, [])
    |> Enum.to_list()
    |> Enum.map(fn
      {:ok, article} ->
        article

      {:error, _} ->
        # TODO: log the error
        nil
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp file_name_to_title(file_name) do
    file_name
    |> String.replace("-", " ")
    |> String.replace("_", " ")
    |> String.capitalize()
  end
end
