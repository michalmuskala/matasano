defmodule Matasano.Set1.Challenge2Test do
  use ExUnit.Case
  import Matasano.BitTools

  test "hex_to_base64" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c" <>
          "696b65206120706f69736f6e6f7573206d757368726f6f6d"
    base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

    assert hex_to_base64("") == ""
    assert hex_to_base64("49276d") == "SSdt"
    assert hex_to_base64(hex) == base64
  end

  test "hex_to_base64 odd-length string" do
    assert hex_to_base64("a") == :error
    assert hex_to_base64("aaa") == :error
  end

  test "xor_strings" do
    first = "1c0111001f010100061a024b53535009181c"
    second = "686974207468652062756c6c277320657965"
    result = "746865206b696420646f6e277420706c6179"

    assert xor_strings("", "") == ""
    assert xor_strings(first, second) == result
  end

  test "xor_strings with different length strings" do
    assert xor_strings("a", "") == :error
    assert xor_strings("aa", "aaa") == :error
  end

  test "xor_strings with odd-length strings" do
    assert xor_strings("a", "a") == :error
    assert xor_strings("abc", "def") == :error
  end
end
