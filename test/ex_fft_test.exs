defmodule ExFftTest do
  use ExUnit.Case
  doctest ExFft

  def dft(list) do
    n = length(list)

    Enum.map(list, fn x -> if is_number(x), do: ComplexNum.new(x), else: x end)

    for k <- 0..(n - 1) do
      for i <- 0..(n - 1) do
        ComplexNum.mult(ExFft.complex_jexp(-2 * Math.pi() / n * i * k), Enum.at(list, i))
      end
      |> Enum.reduce(fn x, acc -> ComplexNum.add(x, acc) end)
    end
  end

  test "FFT result must match DFT one" do
    list = 0..15 |> Enum.map(&Math.sin(&1 * 2 * Math.pi() / 16))
    fft_result = ExFft.fft(list)
    dft_result = dft(list)

    fft_result
    |> Enum.zip(dft_result)
    |> Enum.each(fn {fft_x, dft_x} ->
      assert_in_delta(
        ComplexNum.Cartesian.real(fft_x),
        ComplexNum.Cartesian.real(dft_x),
        :math.pow(10, -3)
      )

      assert_in_delta(
        ComplexNum.Cartesian.imaginary(fft_x),
        ComplexNum.Cartesian.imaginary(dft_x),
        :math.pow(10, -3)
      )
    end)
  end
end
