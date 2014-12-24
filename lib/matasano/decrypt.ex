defmodule Matasano.Decrypt do
  alias Matasano.Frequency
  alias Matasano.BitTools

  def single_byte_xor(ciphers) when is_list(ciphers) do
    ciphers
    |> Enum.map(&single_byte_xor/1)
    |> Enum.filter(&(&1 != :error))
    |> case do
         []   -> :error
         list -> Enum.min_by(list, &Frequency.calculate_and_rate/1)
       end
  end

  def single_byte_xor(cipher) when is_binary(cipher) do
    case Base.decode16(cipher, case: :lower) do
      :error         -> :error
      {:ok, decoded} ->
        1..255
        |> Enum.map(&(BitTools.xor_string(decoded, &1)))
        |> Enum.filter(&String.valid?/1)
        |> case do
             []   -> :error
             list -> Enum.min_by(list, &Frequency.calculate_and_rate/1)
           end
    end
  end
end
