defmodule Boc do
  @moduledoc """
  Documentation for `Boc`.
  """

  def articles_path() do
    Path.join(priv_path(), "articles")
  end

  def priv_path() do
    :code.priv_dir(:boc)
  end
end
