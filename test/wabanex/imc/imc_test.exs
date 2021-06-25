defmodule Wabanex.Imc.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.Imc.IMC

  describe "calculete/1" do
    test "when the file exists, return the data" do
      params = %{"filename" => "students.csv"}

      resposta_esperada =
        {:ok,
         %{
           "Dani" => 21.007667798746546,
           "Diego" => 23.04002019946976,
           "Gabu" => 22.857142857142858,
           "Rafael" => 24.897060231734173,
           "Rodrigo" => 24.691358024691358,
           "Victor" => 22.985397512168742
         }}

      response = IMC.calculate(params)

      assert resposta_esperada == response
    end

    test "When the file does not exist given, displays the error" do
      params = %{"filename" => "uva.csv"}

      resposta_esperada = {:error, "Error while opening the file"}

      response = IMC.calculate(params)

      assert resposta_esperada == response
    end
  end
end
