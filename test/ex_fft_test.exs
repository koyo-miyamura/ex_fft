defmodule ExFftTest do
  use ExUnit.Case
  doctest ExFft

  test "FFT result must match DFT one" do
    list = 0..15 |> Enum.map(&Math.sin(&1 * 2 * Math.pi() / 16))
    fft_result = ExFft.fft(list)
    dft_result = ExFft.dft(list)

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
