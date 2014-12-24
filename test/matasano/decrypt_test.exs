defmodule Matasano.DecryptTest do
  use ExUnit.Case
  alias Matasano.Decrypt

  test "single_byte_xor" do
    cipher = "1b37373331363f78151b7f2b783431333d" <>
             "78397828372d363c78373e783a393b3736"
    deciphered = "Cooking MC's like a pound of bacon"
    assert Decrypt.single_byte_xor(cipher) == deciphered
  end

  test "single_byte_xor with array" do
    ciphers = ["data", "challenge04.txt"]
              |> Path.join
              |> File.stream!
              |> Enum.into([])
              |> Enum.map(&String.strip/1)

    deciphered = "Now that the party is jumping\n"
    assert Decrypt.single_byte_xor(ciphers) == deciphered
  end
end
