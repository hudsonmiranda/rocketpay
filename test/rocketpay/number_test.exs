defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "Havendo arquivo, retorna a soma dos números" do
      responsta = Numbers.sum_from_file("number")
      expectativa_resposta = {:ok, %{resultado: 35}}
      assert responsta == expectativa_resposta
    end

    test "Não havendo arquivo, retorna erro" do
      responsta = Numbers.sum_from_file("numbers")
      expectativa_resposta = {:error, %{message: "INVALID FILE!"}}
      assert responsta == expectativa_resposta
    end
  end
end
