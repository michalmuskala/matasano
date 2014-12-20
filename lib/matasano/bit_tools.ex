defmodule Matasano.BitTools do
  require Bitwise

  @doc """
  Converts hex-encoded string to base64-encoded

  Matasano Set 1 Challenge 1
  """
  def hex_to_base64(""), do: ""

  def hex_to_base64(hex) when rem(byte_size(hex), 2) == 0 do
    case Base.decode16(hex, case: :lower) do
      {:ok, plain} -> Base.encode64(plain)
      :error       -> :error
    end
  end

  def hex_to_base64(_), do: :error

  @doc """
  XORs two hex-encoded strings together

  Matasano Set 1 Challenge 2
  """
  def xor_strings("", ""), do: ""

  def xor_strings(hex1, hex2) when byte_size(hex1) == byte_size(hex2) do
    [hex1, hex2]
    |> Enum.map(&hex_decode_list/1)
    |> List.to_tuple
    |> do_xor_strings
    |> case do
         string when is_binary(string) -> Base.encode16(string, case: :lower)
         :error                        -> :error
       end
  end

  def xor_strings(_, _), do: :error

  defp do_xor_strings({:error, _}), do: :error
  defp do_xor_strings({_, :error}), do: :error

  defp do_xor_strings({string1, string2}) do
    for {x, y} <- Enum.zip(string1, string2), into: "" do
      << Bitwise.bxor(x, y) >>
    end
  end

  defp hex_decode_list(hex) do
    case Base.decode16(hex, case: :lower) do
      {:ok, decoded} -> to_char_list(decoded)
      :error         -> :error
    end
  end
end
