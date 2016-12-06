defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards
  """

  @doc """
    Returns new list of cards in the hand
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suites = ["Diamond", "Hearts", "Clubs", "Spades"]

    for suite <- suites, value <- values do
      "#{value} of #{suite}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck containes a card.

    ## Examples
          iex> deck = Cards.create_deck
          iex> Cards.contains? deck, "Ace of Diamond"
          true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Devides deck to a hand part and rest of the cards.
    `hand_size` defines how many cards should be in the hand.

    ##Examples

        iex> deck = Cards.create_deck
        iex> hand = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Diamond"]
  """
  def deal(deck, hand_size) do
    {hand, _deck } = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do

    case File.read(filename) do
      {:error, _reason} -> "The file #{filename} does not exist."
      {_status, binary} -> :erlang.binary_to_term(binary)
    end
  end

  def create_hand(hand_size) do
    create_deck
     |> shuffle
     |> deal(hand_size)
  end
end
