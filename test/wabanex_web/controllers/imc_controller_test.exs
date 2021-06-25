defmodule WabanexWeb.IMCcontrollerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "see if imc information is consistent", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      expectative_response = %{
        "result" => %{
          "Dani" => 21.007667798746546,
          "Diego" => 23.04002019946976,
          "Gabu" => 22.857142857142858,
          "Rafael" => 24.897060231734173,
          "Rodrigo" => 24.691358024691358,
          "Victor" => 22.985397512168742
        }
      }

      response =
        conn
        |> get(Routes.im_ccontroller_path(conn, :index, params))
        |> json_response(:ok)

      assert expectative_response == response
    end

    test "see if imc information is inconsistent an error in module", %{conn: conn} do
      params = %{"filename" => "uva.csv"}

      expectative_response = %{"result" => "Error while opening the file"}

      response =
        conn
        |> get(Routes.im_ccontroller_path(conn, :index, params))
        |> json_response(:bad_request)

      assert expectative_response == response
    end
  end
end
