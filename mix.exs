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
    [mod: {PushIt, []},
     applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:cowboy,   "~> 1.0"},
      {:ecto,     "~> 0.7"},
      {:json,     "~> 0.3.0"},
      {:phoenix,  "~> 0.8.0"},
      {:poolboy,  "~> 1.4.1"},
      {:postgrex, ">= 0.0.0"},
    ]
  end
end
