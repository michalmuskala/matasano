defmodule Matasano.Frequency do

  @english_frequencies %{
                           ?a => 0.0651738,
                           ?b => 0.0124248,
                           ?c => 0.0217339,
                           ?d => 0.0349835,
                           ?e => 0.1041442,
                           ?f => 0.0197881,
                           ?g => 0.0158610,
                           ?h => 0.0492888,
                           ?i => 0.0558094,
                           ?j => 0.0009033,
                           ?k => 0.0050529,
                           ?l => 0.0331490,
                           ?m => 0.0202124,
                           ?n => 0.0564513,
                           ?o => 0.0596302,
                           ?p => 0.0137645,
                           ?q => 0.0008606,
                           ?r => 0.0497563,
                           ?s => 0.0515760,
                           ?t => 0.0729357,
                           ?u => 0.0225134,
                           ?v => 0.0082903,
                           ?w => 0.0171272,
                           ?x => 0.0013692,
                           ?y => 0.0145984,
                           ?z => 0.0007836,
                           ?\s => 0.1918182
                       }

  def calculate_and_rate(string) do
    string
    |> calculate
    |> normalize
    |> rate
  end

  def calculate(string), do: calculate(string, %{total: 0})

  def calculate("", acc), do: acc

  def calculate(<<c, rest::binary>>, acc) when c in ?a..?z or c == ?\s do
    acc = increment(acc, [:total, c])
    calculate(rest, acc)
  end

  def calculate(<<c, rest::binary>>, acc) when c in ?A..?Z do
    calculate(<< c - ?A + ?a >> <> rest, acc)
  end

  def calculate(<<_c, rest::binary>>, acc) do
    calculate(rest, acc)
  end

  def normalize(%{total: total} = map) do
    for key <- Map.keys(map), key != :total, into: %{} do
      {key, Map.get(map, key) / total}
    end
  end

  def rate(freqs, against \\ @english_frequencies) do
    diff = fn (key, acc) ->
      [freqs, against]
      |> Enum.map(&(Dict.get(&1, key, 0)))
      |> Enum.reduce(&(&1 - &2))
      |> :math.pow(2)
      |> + acc
    end

    [freqs, against]
    |> Enum.map(&Dict.keys/1)
    |> Enum.map(&(Enum.into(&1, HashSet.new)))
    |> Enum.reduce(&Set.union/2)
    |> Enum.reduce(0, diff)
  end

  defp increment(dict, []), do: dict

  defp increment(dict, [key | rest]) do
    dict
    |> Dict.update(key, 1, &(&1 + 1))
    |> increment(rest)
  end
end
