defmodule Cards do

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    # returns tuple containing two enums 
    # (like array, but indexes are meaningful)
    # { [...my_hand], [...rest_of_deck] }
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    deck_as_binary = :erlang.term_to_binary(deck)
    File.write(filename, deck_as_binary)
  end

  def load(filename) do
    case File.read(filename) do
      # destructure result of read, try to pattern match with :ok
      {:ok, binary} -> :erlang.binary_to_term binary
      # if pattern match with :ok fails, try to pattern match with :error
      {:error, _reason} -> "That file does not exist."
    end
  end

  def create_hand(hand_size) do
    # when using the pipe operator, the result of the precending function call
    # is automatically passed as the first arg of the next function call
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
