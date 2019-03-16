defmodule ExFft do
  @moduledoc """
  Documentation for ExFft.
  """

  @doc """
  Culculate FFT

  ## Examples

      iex> ExFft.fft(1)
      :ok1

      iex> ExFft.fft(2)
      :ok

  """
  def fft(n) when n > 1 do
    :ok
  end

  def fft(n) when n == 1 do
    :ok1
  end

  @doc """
    Culculate exp(j*n) for input "n".

    ## Examples

      iex> ExFft.complex_jexp(Math.pi())
      ComplexNum.new(Math.cos(Math.pi()), Math.sin(Math.pi()))

  """
  def complex_jexp(n) do
    ComplexNum.new(Math.cos(n), Math.sin(n))
  end
end
