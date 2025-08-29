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

  def articles_reloader_enabled?() do
    dbg(Application.get_env(:boc, :articles_reloader_enabled))
    Application.get_env(:boc, :articles_reloader_enabled, false)
  end
end
