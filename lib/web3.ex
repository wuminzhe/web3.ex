defmodule Web3 do
  @moduledoc """
  Documentation for Web3.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Web3.hello
      :world

  """
  def is_address?(hex_string) do
    if not Web3.Hex.is_hex?(hex_string) do
      false
    else
      true
    end
  end
end


