defmodule Mixeddoubles.MixProject do
  use Mix.Project

  def project do
    [
      app: :mixeddoubles,
      version: "0.2.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :table_rex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csvlixir, "~> 2.0.4"},
      {:phst_transform, "~> 1.0.2"},
      {:table_rex, "~> 3.1.1"}
    ]
  end
end
