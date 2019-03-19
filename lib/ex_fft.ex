defmodule ExFft do
  @moduledoc """
  Documentation for ExFft.
  """

  @doc """
  Culculate FFT for input list.
  The length of list must be a power of 2

  ## Examples

      iex> ExFft.fft(0..7 |> Enum.map(&Math.sin(&1 * Math.pi())))
      :ok

      iex> ExFft.fft([0,1])
      :length2

  """
  def fft(list) when length(list) > 2 do
    :ok
  end

  def fft(list) when length(list) == 2 do
    :length2
  end

  @doc """
    Culculate exp(j*n) for input "n".

    ## Examples

      iex> ExFft.complex_jexp(Math.pi())
      ComplexNum.new(Math.cos(Math.pi()), Math.sin(Math.pi()))
      iex> ExFft.complex_jexp(0)
      ComplexNum.new(1.0, 0.0)

  """
  def complex_jexp(n) do
    ComplexNum.new(Math.cos(n), Math.sin(n))
  end
end

# memo
# Wn はあらかじめ計算しておく
