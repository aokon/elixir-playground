defmodule Servy.PledgeController do
  def create(conv, %{"name" => name, "amount" => amount}) do
    # Sends the pledge to the external service and caches it
    create_pledge(name, String.to_integer(amount))

    %{ conv | status: 201, resp_body: "#{name} pledged #{amount}!" }
  end

  def index(conv) do
    # Gets the recent pledges from the cache
    pledges = recent_pledges()

    %{ conv | status: 200, resp_body: (inspect pledges) }
  end

  defp create_pledge(_name, _amount) do

  end

  defp recent_pledges do

  end
end
