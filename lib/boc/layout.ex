defmodule Boc.Layout do
  require EEx

  EEx.function_from_file(:def, :render, Path.join(Boc.priv_path(), "layout.html.eex"), [:article])
end
