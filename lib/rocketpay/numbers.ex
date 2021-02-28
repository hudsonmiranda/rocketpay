defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    "#{filename}.csv"
    |>File.read()
    |>handle_file()

  end

  defp handle_file({:ok, resultado}) do
    resultado=
      resultado
      |>String.split(",")
      # |>Enum.map(fn num -> String.to_integer(num) end)
      |>Stream.map(fn num -> String.to_integer(num) end)
      |>Enum.sum()
    {:ok, %{resultado: resultado}}
    # resultado
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "INVALID FILE!"}}
end
