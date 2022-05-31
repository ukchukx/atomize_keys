defmodule AtomizeKeys.Mixfile do
  use Mix.Project

  def project do
    [
      app: :atomize_keys,
      version: "1.2.0",
      elixir: "~> 1.5",
      build_permanent: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp description do
    """
    A tool to convert string map keys to atoms or atom map keys to strings.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Uk Chukundah"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ukchukx/atomize_keys",
               "Docs"   => "https://hexdocs.pm/atomize_keys"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp aliases do
    [
      compile: ["compile --docs"]
    ]
  end
end
