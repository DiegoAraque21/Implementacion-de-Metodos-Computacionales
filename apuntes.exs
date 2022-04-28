# Notes
#
# Diego Araque
# 2022-04-26

defmodule Tlists do
  @moduledoc """
  Functions to work with lists
  """

  @doc """
  Sum all the numbers in a list using tail recursion
  """
  def sum(list), do: do_sum(list,0)
  defp do_sum([], result), do: result
  defp do_sum(list, result), do: do_sum(tl(list), result + hd(list))

  @doc """
  Sum all the numbers in a list using pattern matching
  """
  def sum_2(list), do: do_sum_2(list,0)
  defp do_sum_2([], result), do: result
  defp do_sum_2([head | tail], result), do: do_sum_2(tail, result+head)

  @doc """
  Filter a list and keep only positive elements
  """
  def positives(list), do: do_positives(list, [])
  defp do_positives([], result), do: Enum.reverse(result)
  defp do_positives([head | tail], result) when head > 0, do: do_positives(tail, [head | result])
  defp do_positives([_head | tail], result), do: do_positives(tail, result)
end
