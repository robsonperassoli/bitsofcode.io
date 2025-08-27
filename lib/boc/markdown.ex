defmodule Boc.Markdown do
  def parse(markdown) do
    with {:ok, meta, content} <- extract_front_matter(markdown),
         {:ok, html} <- to_html(content) do
      {:ok, %{meta: meta, markdown: content, html: html}}
    end
  end

  defp extract_front_matter(markdown) do
    front_matter_split_regex = ~r/\A---\s*\n(.*?)\n---\s*(?:\n([\s\S]*))?\z/s

    case Regex.run(front_matter_split_regex, markdown) do
      [_, front_matter_yaml, content] ->
        # TODO: handle this error properly
        {:ok, [front_matter]} = YamlElixir.read_all_from_string(front_matter_yaml)

        {:ok, front_matter, content}

      _ ->
        {:ok, %{}, markdown}
    end
  end

  defp to_html(markdown) do
    case Earmark.as_html(markdown) do
      {:ok, html, _} ->
        {:ok, html}

      {:error, _, _error} ->
        # should i log this or just return? I think log is the proper thing to do
        {:error, :invalid_markdown}
    end
  end
end
