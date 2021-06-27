defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Gabriel", email: "gabriel@email.com", password: "123567"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true, changes: %{email: "gabriel@email.com", name: "Gabriel", password: "123567"},
         errors: []
         } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "G", email: "gabriel@email.com"}

      response = User.changeset(params)

      expected_response = %{name: ["should be at least 2 character(s)"], password: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

end
