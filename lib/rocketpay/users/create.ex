defmodule Rocketpay.Users.Create do
  alias Rocketpay.{Repo, User, Account}
  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |>Multi.insert(:create_user, User.changeset(params))
    |>Multi.run(:create_account, fn repo, %{create_user: user} ->
      repo.insert(account_changeset(user.id))
    end)
    |>Multi.run(:preload_data, fn repo, %{create_user: user} ->
      {:ok, repo.preload(user, :account)}
    end)
    |>run_transaction()
  end

  # def call(params) do
  #   params
  #   |>User.changeset()
  #   |>Repo.insert()
  # end

  defp account_changeset(user_id), do: Account.changeset(%{user_id: user_id, balance: "0.00"})

  # defp account_changeset(user_id) do
  #   params = %{user_id: user_id, balance: "0.00"}
  #   Account.changeset(params)
  # end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      # {:ok, %{create_account: account}} -> IO.inspect(account)
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
