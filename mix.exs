defmodule ExFft.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_fft,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: "Elixir's FFT (Fast Fourier Transform) library (not FINAL FANTASY TACTICS)",
      package: [
        maintainers: ["koyo"],
        licenses: ["Apache 2.0"],
        links: %{"GitHub" => "https://github.com/koyo-miyamura/ex_fft"}
      ],
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:complex_num, "~> 1.1"},
      {:math, "~> 0.3.0"},
      {:ex_doc, "~> 0.19.3", only: :dev, runtime: false},
      {:mix_test_watch, "~> 0.9", only: :dev, runtime: false}
    ]
  end
end
