defmodule Wabanex.Users.Delete do
  alias Wabanex.Repo
  alias Wabanex.Users.Get

  def deleta(id) do
    id
    |> Get.call()
    |> handler_response()
  end

  defp handler_response({:ok, props}) do
    props
    |> Repo.delete!()

    {:ok, "Usuario deletado"}
  end

  defp handler_response({:error, pramas}) do
    {:error, pramas}
  end
end
