defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps(),
      docs: [
        main: "Issues",
        extras: ["README.md"],
        markdown_processor: ExDoc.Markdown.Cmark
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript do
    [
      main_module: Issues.CLI
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19.3", only: :dev, runtime: false},
      {:cmark, "~> 0.6", only: :dev},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end
end
