defmodule Dates do
  def date_parts(date) do
    [y_str, m_str, d_str] = String.split(date, "-")
    [String.to_integer(y_str), String.to_integer(m_str), String.to_integer(d_str)]
  end
end
