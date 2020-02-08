defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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

  @doc """
    Determines whether a deck contains a given card

  ## Examples
    
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Splits a deck into a hang and the remainder of the deck.
    The `hand_size` arg indicates how many cards should be in the hand.

  ## Examples
    
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand  
      ["Ace of Spades"]
  """
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
