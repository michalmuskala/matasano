defmodule Matasano.FrequencyTest do
  use ExUnit.Case
  alias Matasano.Frequency

  test "calculate" do
    assert Frequency.calculate("") == %{total: 0}
    assert Frequency.calculate("a") == %{?a => 1, :total => 1}
    assert Frequency.calculate("ab") == %{?a => 1, ?b => 1, :total => 2}
    assert Frequency.calculate("aaa") == %{?a => 3, :total => 3}
    assert Frequency.calculate("Aa") == %{?a => 2, :total => 2}
  end

  test "normalize" do
    original = %{?a => 1,   ?b => 1,   :total => 2}
    result   = %{?a => 0.5, ?b => 0.5}
    assert Frequency.normalize(original) == result

    original = %{?a => 3,   ?b => 5,   ?c => 2, :total => 10}
    result   = %{?a => 0.3, ?b => 0.5, ?c => 0.2}
    assert Frequency.normalize(original) == result
  end

  test "rate against empty frequencies" do
    freqs = %{?a => 1}
    against = %{}
    assert Frequency.rate(freqs, against) == 1
  end

  test "rate against dummy frequencies" do
    freqs = %{?a => 0.5, ?b => 0.3, ?c => 0.2}
    against = %{?a => 0.2, ?b => 0.3, ?c => 0.5}
    assert Frequency.rate(freqs, against) == 0.18
  end

  test "rate against default English" do
    freqs = %{?a => 0.0625, ?c => 0.0625, ?d => 0.0625, ?e => 0.0625,
              ?f => 0.125, ?h => 0.0625, ?l => 0.125, ?o => 0.125,
              ?r => 0.0625, ?s => 0.125, ?u => 0.125}
    assert_in_delta Frequency.rate(freqs), 0.094, 0.001
  end
end
