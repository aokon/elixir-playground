defmodule RabbitmqTutorials.Receiver do
  def call do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.consume(channel, "hello", nil, no_ack: true)
    IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"

    wait_for_messages()
  end

  defp wait_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " [x] Received #{payload}"
        wait_for_messages()
    end
  end
end
