defmodule ExFft do
  @moduledoc """
  Documentation for ExFft.
  """

  @doc """
  Culculate FFT for input list.
  List member's type must be number or ComplexNum
  The length of list must be a power of 2

  ## Examples

      iex> ExFft.fft(0..15 |> Enum.map(&Math.sin(&1 * 2*Math.pi()/16)))
      :ok

      iex> ExFft.fft([ComplexNum.new(2),ComplexNum.new(1)])
      [ComplexNum.new(3), ComplexNum.new(1)]
      iex> ExFft.fft([2,1])
      [ComplexNum.new(3), ComplexNum.new(1)]

  """
  def fft(list) do
    list
    |> Enum.map(fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)
    |> fft_calc()
  end

  defp fft_calc(list) when length(list) > 2 do
    n = length(list)
    fe = Enum.take_every(list, 2) |> fft_calc()
    fo = Enum.drop_every(list, 2) |> fft_calc()

    first_half =
      for i <- 0..(div(n, 2) - 1) do
        ComplexNum.add(
          Enum.at(fe, i),
          ComplexNum.mult(complex_jexp(-2 * Math.pi() / n * i), Enum.at(fo, i))
        )
      end

    latter_half =
      for i <- 0..(div(n, 2) - 1) do
        ComplexNum.sub(
          Enum.at(fe, i),
          ComplexNum.mult(complex_jexp(-2 * Math.pi() / n * i), Enum.at(fo, i))
        )
      end

    first_half ++ latter_half
  end

  defp fft_calc(list) when length(list) == 2 do
    [
      Enum.reduce(list, fn x, acc -> ComplexNum.add(acc, x) end),
      Enum.reduce(list, fn x, acc -> ComplexNum.sub(acc, x) end)
    ]
  end

  @doc """
    Culculate IFFT for input list.

    ## Examples

      iex> ExFft.ifft([ComplexNum.new(2), ComplexNum.new(1)])
      [ComplexNum.new(1.5,0.0), ComplexNum.new(0.5,0.0)]
      iex> ExFft.ifft([2,1])
      [ComplexNum.new(1.5,0.0), ComplexNum.new(0.5,0.0)]

  """
  def ifft(list) do
    n = length(list)

    list
    |> Enum.map(fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)
    |> Enum.map(fn x -> ComplexNum.Cartesian.conjugate(x) end)
    |> fft_calc()
    |> Enum.map(fn x -> ComplexNum.Cartesian.conjugate(x) |> ComplexNum.div(n) end)
  end

  @doc """
    Culculate exp(j*n) for input "x" and "x" is a number type.

    ## Examples

      iex> ExFft.complex_jexp(Math.pi())
      ComplexNum.new(Math.cos(Math.pi()), Math.sin(Math.pi()))
      iex> ExFft.complex_jexp(0)
      ComplexNum.new(1.0, 0.0)

  """
  def complex_jexp(x) do
    ComplexNum.new(Math.cos(x), Math.sin(x))
  end
end

# memo
# Wn はあらかじめ計算しておく
