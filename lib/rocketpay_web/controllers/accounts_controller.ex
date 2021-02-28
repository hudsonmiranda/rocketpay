defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller
  action_fallback RocketpayWeb.FallbackController
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def deposit(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      connection
      |>put_status(:ok)
      |>render("update.json", account: account)
    end
  end

  def withdraw(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      connection
      |>put_status(:ok)
      |>render("update.json", account: account)
    end
  end

  def transaction(connection, params) do
    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      connection
      |>put_status(:ok)
      |>render("transaction.json", transaction: transaction)
    end
  end
end
