defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "all valid parameters for returns the changeset" do
      params = %{name: "victor", email: "victorlol1@gmail.com", password: "12123121"}

      response = User.changeset(params)

      assert(
        %Ecto.Changeset{
          valid?: true,
          changes: %{name: "victor", email: "victorlol1@gmail.com", password: "12123121"},
          errors: []
        } = response
      )
    end

    test "all invalid parameters for returns the invalid changeset" do
      params = %{name: "a", email: "victorgmail.com"}

      response_expected = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      response = User.changeset(params)

      assert errors_on(response) == response_expected
    end
  end
end
