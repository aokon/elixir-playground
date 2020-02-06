defmodule Servy.Fetcher do
  def async(func) do
    current = self()

    spawn(fn -> send(current, {self(), func.()}) end)
  end

  def await(pid) do
    receive do
      {^pid, result} -> result
    after 2000 ->
        raise "Time out!"
    end
  end
end
