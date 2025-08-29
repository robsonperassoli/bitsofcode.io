defmodule Boc.Articles.DB do
  use Agent

  def start_link(_initial_value) do
    Agent.start_link(&prepare_articles/0, name: __MODULE__)
  end

  def get_article(key) do
    Agent.get(__MODULE__, &Map.get(&1, key))
  end

  def put_article(%{key: key} = article) do
    Agent.update(__MODULE__, &Map.put(&1, key, article))
  end

  def reset() do
    Agent.update(__MODULE__, fn _ -> prepare_articles() end)
  end

  defp prepare_articles() do
    Boc.Articles.compile_articles()
    |> Enum.map(&{&1.key, &1})
    |> Map.new()
  end
end
