defmodule Wabanex.Users.Delete do
  alias Wabanex.Repo
  alias Wabanex.Users.Get

  def deleta(id) do
    id
    |> Get.call()
    |> case do
      {:ok, id} ->
        Repo.delete(id)

      {:error, _} ->
        "Error not found id for user"
    end
  end
end
