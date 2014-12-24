defmodule Matasano.BitToolsTest do
  use ExUnit.Case
  alias Matasano.BitTools

  test "hex_to_base64" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c" <>
          "696b65206120706f69736f6e6f7573206d757368726f6f6d"
    base64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

    assert BitTools.hex_to_base64("") == ""
    assert BitTools.hex_to_base64("49276d") == "SSdt"
    assert BitTools.hex_to_base64(hex) == base64
  end

  test "hex_to_base64 odd-length string" do
    assert BitTools.hex_to_base64("a") == :error
    assert BitTools.hex_to_base64("aaa") == :error
  end

  test "xor_strings" do
    first = "1c0111001f010100061a024b53535009181c"
    second = "686974207468652062756c6c277320657965"
    result = "746865206b696420646f6e277420706c6179"

    assert BitTools.xor_strings("", "") == ""
    assert BitTools.xor_strings(first, second) == result
  end

  test "xor_strings with different length strings" do
    assert BitTools.xor_strings("a", "") == :error
    assert BitTools.xor_strings("aa", "aaa") == :error
  end

  test "xor_strings with odd-length strings" do
    assert BitTools.xor_strings("a", "a") == :error
    assert BitTools.xor_strings("abc", "def") == :error
  end

  test "xor_string" do
    assert BitTools.xor_string("", ?a) == ""
    assert BitTools.xor_string("abc", ?a) == <<0, 3, 2>>
  end

  test "xor_string with invalid input" do
    assert BitTools.xor_string('', ?a) == :error
  end
end
