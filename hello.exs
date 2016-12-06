IO.puts "Hello exlir!!!"

sum = fn (a, b, c) -> a + b + c end

list_concat = fn (firstList, secondList) -> firstList ++ secondList end

pair_tuple_to_list = fn ({a, b}) -> [a, b] end

handle_open = fn
  {:ok , file} -> "First line #{IO.read(file, :line)}"
  {_, error} -> "Oh shit!! It's no exists #{:file.format_error(error)}"
end

fizz_buzz = fn
  {0, 0, _} -> "FizzBuzz"
  {0, _, _} -> "Fizz"
  {_, 0, _} -> "Buzz"
  {_, _, c} -> c
end

call_fizz = fn (n) ->
  fizz_buzz.({rem(n, 3), rem(n, 5), n})
end

#IO.puts call_fizz.(10)
#IO.puts call_fizz.(11)
#IO.puts call_fizz.(12)
#IO.puts call_fizz.(13)
#IO.puts call_fizz.(14)
#IO.puts call_fizz.(15)
#IO.puts call_fizz.(16)
