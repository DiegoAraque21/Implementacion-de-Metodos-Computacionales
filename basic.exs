# First functions in Elixir
#
# Diego Araque
# 2022-04-08

defmodule Learn do
  @doc """
  Compute the factorial of x
  """
  def fact(x) do
    if x == 0 do
      1
    else
      x * fact(x-1)
    end
  end

  def factorial(0), do: 1
  def factorial(x), do: x * factorial(x-1)

  def factCol(x, a) do
    if x == 0 do
      a
    else
      factCol(x-1, x*a)
    end
  end

  def fibonacci(t, o, a, acumulador) do

  end
end
