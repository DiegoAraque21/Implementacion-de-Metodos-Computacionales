# Tarea Programacion funcional parte 2
#
# Diego Araque and Daniel Sanchez
# 2022 - 05 - 13

defmodule Hw.Ariel2 do
  @doc """
  Excercise 1: Insert function
  """

  # Default function, the one that is called from the terminal
  def insert(list, num), do: do_insert(num, list, [])
  # When the the user gives an empty list case
  defp do_insert(num, [], []), do: [num]
  # When the num that is going to be inserted
  # is the biggest one, so it requires an special case
  defp do_insert(num, [], result), do: do_insert_final([num | result])
  # Last step, where we reverse the result list and return it
  defp do_insert_final(result), do: Enum.reverse(result)
  # When the number that is going to be inserted is smaller
  # than the first number (head) of the new list. The number is inserted
  # before the head(this list only has one value) into the result list.
  defp do_insert(num, [head], result) when num <= head, do:
    do_insert_final([head, num | result])
  # When the number that is going to be inserted is smaller
  # than the first number (head) of the new list. The number is inserted
  # before the head into the result list. The list given to this function
  # has more than one value, therefore do_insert_tail() is called.
  defp do_insert(num, [head | tail], result) when num <= head, do:
    do_insert_tail(tail ,[head, num | result])
  # Number is greater than the head element, therefore a normal insert is done again.
  # Until the number and head satisfy the other condition
  defp do_insert(num, [head | tail], result) when num > head, do:
    do_insert(num, tail, [head | result])
  # When there is only one element in the list and the number insertion
  # has already been done
  defp do_insert_tail([head], result), do:
    do_insert_final([head | result])
  # When there is more than one element in the list and the number insertion
  # has already been done
  defp do_insert_tail([head | tail], result), do:
    do_insert_tail(tail, [head | result])

  @doc """
  Excercise 2: Insertion sort
  """

  # Default function called from the terminal, gets a list as an argument
  def insertion_sort(list), do: do_insertion_sort([], list)
  # In this step the result list already has a value, and we call the addNum to add it
  # to its correct position
  defp do_insertion_sort(result, [head | tail]), do:
    do_insertion_sort(addNum(head, result), tail)
  # When the old list has no more value, the resulr is returned
  defp do_insertion_sort(result, []), do: result
  # The first step, it adds the first number to our result list
  defp addNum(num, []), do: [num]
  # If the number that is going to be inserted is smaller than the first element
  # from the given list. The number is inserted accordingly
  defp addNum(num, [head | tail]) when head >= num , do: [num | [head | tail]]
  # If the number that is going to be inserted is greater than the first element
  # from the given list. The function is called again recursively but leaving
  #the head of that list in its respective position
  defp addNum(num, [head | tail]) when head < num , do: [head | addNum(num, tail)]

  @doc """
  Excercise 3: Rotate left
  """

  # Public function called from the termianl
  def rotate_left(list, n), do: do_rotate_left(list, n, [])
  # When the list given has no values, an empty list is returned
  defp do_rotate_left([], _n, []), do: []
  # When the number is given from the beginning is larger than the
  # length of the list. The procces is repeated until the n variables is 0
  defp do_rotate_left([], n, result) when n != 0, do:
    do_rotate_left(result, n, [])
  # If the number given from the beginning is 0, the original list
  # is returned
  defp do_rotate_left(list, 0, []), do: list
  # When the n variable gets to zero, the remaining of the original list
  # is united with the result list. And the correct rotation is returned
  defp do_rotate_left(list, 0, result), do: list ++ result
  # In this step the original list is transformed to just its tail,
  # the variable n is decreased by 1 and the result list gets the head
  # added to it. This step is done only when the number is greater than 0
  # and when the original number is positive
  defp do_rotate_left([head | tail], n, result) when n > 0, do:
    do_rotate_left(tail, n-1, result ++ [head])
  # If the original number is negative, the list is reversed,
  # the number is transformed to positive, and the do_negative_rotation()
  # function is called
  defp do_rotate_left(list, n, []), do:
    do_negative_rotation(Enum.reverse(list), -n, [])
  # Same  procces as the one on line 76, but for the negative rotation
  defp do_negative_rotation([], n, result) when n != 0, do:
    do_negative_rotation(result, n, [])
  # Final return for the negative rotation, both list need to be reversed
  # before being addded to each other
  defp do_negative_rotation(list, 0, result), do:
    Enum.reverse(result) ++ Enum.reverse(list)
  # Same procces as the one in line 88 but for the negative number
  defp do_negative_rotation([head | tail], n, result) when n > 0, do:
    do_negative_rotation(tail, n-1, result ++ [head])

  @doc """
  Excercise 10: Encode
  """
  # Public function, recieves a list
  def encode(list), do: do_encode(list, [], 1)
  # If the list recieved is empty, an empty list is returned
  defp do_encode([], _result, _acc), do: []
  # When the first two elements are the same, 1 is summed
  # to the accumulator. And the function is called again
  defp do_encode([head, second| tail], result, acc) when head == second, do:
    do_encode([second | tail], result, acc+1)
  # When they are different the new list is added to the result array
  defp do_encode([head, second| tail], result, acc) when head != second, do:
    do_encode([second | tail], [{acc, head} | result], 1)
  # Final step, the result list is reversed
  defp do_encode([head], result, acc), do:
    Enum.reverse([{acc, head} | result])
end
