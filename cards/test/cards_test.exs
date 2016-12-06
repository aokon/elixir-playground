defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates 20 cards in the deck" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
