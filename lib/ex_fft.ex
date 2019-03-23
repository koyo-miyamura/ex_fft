defmodule ExFft do
  @moduledoc """
  ExFft is module for FFT (Fast Fourier Transform)
  """

  @doc """
  Calculate FFT for input `list` \n
  List member's type must be number or `ComplexNum` \n
  The length of `list` must be a power of 2 \n
  if `norm` is `:ortho`, transform will be scaled by `1/Math.sqrt(length(list))`

  ## Examples

      iex> ExFft.fft([2,1])
      [ComplexNum.new(3), ComplexNum.new(1)]
      iex> ExFft.fft([ComplexNum.new(2),ComplexNum.new(1)])
      [ComplexNum.new(3), ComplexNum.new(1)]

      iex> ExFft.fft([2,1], :ortho)
      [ComplexNum.new(2.1213203435596424, 0.0), ComplexNum.new(0.7071067811865475, 0.0)]

      iex> list = 0..15 |> Enum.map(fn x -> Math.sin(x * 2*Math.pi()/16) |> Float.round(3) end)
      iex> list_fft_ifft =
      ...> list
      ...> |> ExFft.fft() |> ExFft.ifft()
      ...> |> Enum.map(fn x -> ComplexNum.Cartesian.real(x) |> Float.round(3) end)
      iex> Keyword.equal?(list, list_fft_ifft)
      true

  """
  @spec fft([number | ComplexNum], :none | :ortho) :: [ComplexNum]
  def fft(list, norm \\ :none) do
    list =
      list
      |> Enum.map(fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)
      |> fft_calc()

    case norm do
      :none -> list
      :ortho -> Enum.map(list, fn x -> ComplexNum.div(x, Math.sqrt(length(list))) end)
    end
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
  Calculate IFFT for input `list` \n
  if `norm` is `:ortho`, transform will be scaled by `1/Math.sqrt(length(list))`, else `1/length(list)`

  ## Examples

      iex> ExFft.ifft([2,1])
      [ComplexNum.new(1.5,0.0), ComplexNum.new(0.5,0.0)]
      iex> ExFft.ifft([ComplexNum.new(2), ComplexNum.new(1)])
      [ComplexNum.new(1.5,0.0), ComplexNum.new(0.5,0.0)]

      iex> ExFft.ifft([2,1], :ortho)
      [ComplexNum.new(2.1213203435596424,0.0), ComplexNum.new(0.7071067811865475,0.0)]

  """
  @spec ifft([number | ComplexNum], :none | :ortho) :: [ComplexNum]
  def ifft(list, norm \\ :none) do
    coef =
      case norm do
        :none -> length(list)
        :ortho -> Math.sqrt(length(list))
      end

    list
    |> Enum.map(fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)
    |> Enum.map(fn x -> ComplexNum.Cartesian.conjugate(x) end)
    |> fft_calc()
    |> Enum.map(fn x -> ComplexNum.Cartesian.conjugate(x) |> ComplexNum.div(coef) end)
  end

  @doc """
  Calculate `exp(j*n)` for input `x` and `x` is a number type.

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
