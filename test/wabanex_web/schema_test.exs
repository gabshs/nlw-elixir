defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "gabriel@email.com", name: "Gabriel", password: "123123"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          name
          email
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{"data" => %{"getUser" => %{"email" => "gabriel@email.com", "name" => "Gabriel"}}}

      assert expected_response == response
    end
  end

  describe "users mutations" do
    test "When all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Gabriel3", email: "gabriel3@email.com", password: "123123"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

        assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Gabriel3"}}} = response
    end
  end
end
