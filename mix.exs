defmodule SkeletonPermission.MixProject do
  use Mix.Project

  @version "2.0.0"
  @source_url "https://github.com/skeleton-elixir/skeleton_permission"
  @maintainers [
    "Diego Nogueira",
    "Jhonathas Matos"
  ]

  def project do
    [
      name: "SkeletonPermission",
      app: :skeleton_permission,
      version: @version,
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      source_url: @source_url,
      description: description(),
      maintainers: @maintainers,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  defp description() do
    "O Skeleton Permission ajuda a controlar toda parte de autorização do seu sistema,
    seja via Controller, Resolver(Absinthe), View e LiveView."
  end

  defp elixirc_paths(:test), do: ["lib", "test/app", "test/app_web"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      files: ~w(lib CHANGELOG.md LICENSE mix.exs README.md),
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "#{@source_url}/blob/master/CHANGELOG.md"
      }
    ]
  end
end
