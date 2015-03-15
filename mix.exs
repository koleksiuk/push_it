defmodule PushIt.Mixfile do
  use Mix.Project

  def project do
    [app: :push_it,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {PushIt, []},
      applications: [
        :cowboy,
        :ecto,
        :ibrowse,
        :logger,
        :phoenix,
        :postgrex,
      ]
   ]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:cowboy,    "~> 1.0"},
      {:dialyze,   "~> 0.1.3"},
      {:ecto,      "~> 0.7"},
      {:httpotion, "~> 2.0.0"},
      {:ibrowse,   github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
      {:json,      "~> 0.3.2"},
      {:mock,      github: "jjh42/mock", env: :test },
      {:phoenix,   "~> 0.8.0"},
      {:poolboy,   "~> 1.4.1"},
      {:postgrex,  ">= 0.0.0"},
    ]
  end
end
