# ExFft
[![hex.pm version](https://img.shields.io/hexpm/v/ex_fft.svg)](https://hex.pm/packages/ex_fft)
[![hex.pm](https://img.shields.io/hexpm/l/ex_fft.svg)](https://github.com/koyo-miyamura/ex_fft/blob/master/LICENSE)

Elixir's FFT (Fast Fourier Transform) library

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_fft` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_fft, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_fft](https://hexdocs.pm/ex_fft).

If you want to compare with DFT, access `ex_fft_test.exs`, copy `dft` function, paste it in `ex_fft.ex`, and run `iex -S mix`
