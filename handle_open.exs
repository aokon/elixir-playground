handle_open = fn
  {:ok, file } -> "First line : #{IO.read(file, :line)}"
  { _, error } -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open.(File.open("text.txt"))
IO.puts handle_open.(File.open("text2.txt"))

IO.puts "==============================="

fizz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fiz"
  (_,0,_) -> "Buzz"
  (_,_,c) -> c
end

IO.puts fizz.(0,0,1)
IO.puts fizz.(0,2,1)
IO.puts fizz.(2,0,1)
IO.puts fizz.(2,3,1)

IO.puts "==============================="

rem_fizz = fn(n) -> fizz.(rem(n,3), rem(n,5), n) end

IO.puts rem_fizz.(10)
IO.puts rem_fizz.(11)
IO.puts rem_fizz.(12)
IO.puts rem_fizz.(13)
IO.puts rem_fizz.(14)
IO.puts rem_fizz.(15)
IO.puts rem_fizz.(16)


IO.puts "==============================="

prefix = fn(prefix) -> (fn(name) -> "#{prefix} #{name}" end) end

IO.puts prefix.("Mrs").("Smith")
IO.puts prefix.("Elixir").("Rocks")

IO.puts "==============================="

defmodule Hi do
  def for(name, greating) do
    fn
      (^name) -> "#{greating} #{name}"
      (_) -> "I don't know you"
    end
  end
end

mr_valin = Hi.for("Valin", "hello!")

IO.puts mr_valin.("Valin")
IO.puts mr_valin.("adam")

IO.puts "==============================="
