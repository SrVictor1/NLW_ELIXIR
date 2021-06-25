defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "useres queries" do
    test "whe a valid id is givem, returns the user", %{conn: conn} do
      params = %{
        email: "victor@gmail.com",
        name: "victor",
        password: "1297742"
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          id
          name
          email
        }
      }
      """

      expectative_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "victor@gmail.com",
            "id" => "#{user_id}",
            "name" => "victor"
          }
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert expectative_response == response
    end

    test "whe a invalid id is givem, returns the invalid user give errors", %{conn: conn} do
      query = """
      {
        getUser(id: ""){
          name
          email
        }
      }
      """

      expectative_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 11, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"\"."
          }
        ]
      }

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      assert expectative_response == response
    end
  end

  describe "useres mutations" do
    test "whe a valid is givem dados, create the user", %{conn: conn} do
      mutation = """
          mutation {
            createUser(input: {
              name: "victor",
              email: "victor@gmail.com",
              password: "194188792h"
            }) {
              name
            }
          }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expectative_response = %{
        "data" => %{"createUser" => %{"name" => "victor"}}
      }

      assert response == expectative_response
    end

    test "whe a invalid dados is givem, create the user error", %{conn: conn} do
      mutation = """
          mutation {
            createUser(input: {
              name: "victor",
              email: "victor@gmail.com"
            }) {
              name
            }
          }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expectative_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 18, "line" => 2}],
            "message" =>
              "Argument \"input\" has invalid value {name: \"victor\", email: \"victor@gmail.com\"}.\nIn field \"password\": Expected type \"String!\", found null."
          }
        ]
      }

      assert response == expectative_response
    end
  end
end
