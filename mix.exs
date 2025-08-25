defmodule Boc.MixProject do
  use Mix.Project

  def project do
    [
      app: :boc,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Boc.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.18.1"},
      {:bandit, "~> 1.8"}
    ]
  end
end
