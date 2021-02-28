defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller
  action_fallback RocketpayWeb.FallbackController
  alias Rocketpay.User

  def create(connection, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      connection
      |>put_status(:created)
      |>render("create.json", user: user)
    end
  end

  # def create(connection, params) do
  #   params
  #   |>Rocketpay.create_user()
  #   |>handle_response(connection)
  # end

  # defp handle_response({:ok, %User{} = user}, connection) do
  #   connection
  #   |>put_status(:created)
  #   # |>IO.inspect()
  #   |>render("create.json", user: user)
  # end

  # defp handle_response({:error, _reason} = erro, _connection), do: erro
end
