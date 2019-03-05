defmodule Httpy.MixProject do
  use Mix.Project

  def project do
    [
      app: :httpy,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Httpy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_octopus, github: "jeffkreeftmeijer/plug_octopus"},
      {:plug, "~> 1.7"}
    ]
  end
end
