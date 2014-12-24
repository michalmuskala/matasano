defmodule Matasano.Encrypt do
  require Bitwise

  def repeating_xor(plaintext, key) do
    encode = fn {letter, key} ->
      Bitwise.bxor(letter, key)
    end
    plaintext
    |> to_char_list
    |> Enum.zip(Stream.cycle(key))
    |> Enum.map(encode)
    |> to_string
    |> Base.encode16(case: :lower)
  end
end
