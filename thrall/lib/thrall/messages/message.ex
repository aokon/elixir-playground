defmodule Thrall.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :content, :string
    field :recipient, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:recipient, :content])
    |> validate_required([:recipient, :content])
  end
end
