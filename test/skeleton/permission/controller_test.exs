defmodule Skeleton.Phoenix.ControllerTest do
  use Skeleton.App.TestCase

  import Plug.Conn

  alias Plug.Conn
  alias Skeleton.App.User
  alias Skeleton.AppWeb.UserController

  setup context do
    conn = %Conn{}
    Map.put(context, :conn, conn)
  end

  describe "check permisssion" do
    test "when is permitted", context do
      user = %User{id: 1}

      conn =
        context.conn
        |> assign(:current_user, user)
        |> assign(:user, user)
        |> UserController.update()

      refute conn.halted
      refute conn.status
    end

    test "when isn't permitted", context do
      user1 = %User{id: 1}
      user2 = %User{id: 2}

      conn =
        context.conn
        |> assign(:current_user, user1)
        |> assign(:user, user2)
        |> UserController.update()

      assert conn.halted
      assert conn.status == 401
    end
  end

  describe "permit params" do
    setup context do
      put_in(context.conn.params, %{
        "name" => "my name",
        "email" => "email@email.com",
        "admin" => true
      })
    end

    test "when is permitted", context do
      user1 = %User{id: 1, admin: true}
      user2 = %User{id: 1}

      conn =
        context.conn
        |> assign(:current_user, user1)
        |> assign(:user, user2)
        |> UserController.update()

      refute conn.halted
      refute conn.status
      assert conn.params["name"] == "my name"
      assert conn.params["email"] == "email@email.com"
      assert conn.params["admin"]
    end

    test "when isn't permitted", context do
      user = %User{id: 1}

      conn =
        context.conn
        |> assign(:current_user, user)
        |> assign(:user, user)
        |> UserController.update()

      refute conn.halted
      refute conn.status
      assert conn.params["name"] == "my name"
      assert conn.params["email"] == "email@email.com"
      refute conn.params["admin"]
    end
  end
end
