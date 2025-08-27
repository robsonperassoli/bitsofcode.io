defmodule Boc.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, plug: Boc.Router},
      {Boc.Articles.DB, []}
    ]

    opts = [strategy: :one_for_one, name: Boc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
