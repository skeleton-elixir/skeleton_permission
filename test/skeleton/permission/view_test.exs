defmodule Skeleton.Permission.ViewTest do
  use Skeleton.App.TestCase
  import Plug.Conn
  alias Plug.Conn
  alias Skeleton.App.{User, UserView}

  setup context do
    conn = %Conn{}
    Map.put(context, :conn, conn)
  end

  test "preloads with atom and check users permissions", context do
    user1 = %User{id: 1}
    user2 = %User{id: 2}
    user3 = %User{id: 3}

    users = [user1, user2, user3]

    result =
      context.conn
      |> assign(:current_user, user1)
      |> UserView.with_preload_atom(users)

    assert result == [true, false, false]
  end

  test "preloads with list and check users permissions", context do
    user1 = %User{id: 1}
    user2 = %User{id: 2}
    user3 = %User{id: 3}

    users = [user1, user2, user3]

    result =
      context.conn
      |> assign(:current_user, user1)
      |> UserView.with_preload_list(users)

    assert result == [true, false, false]
  end

  test "preloads and check users permissions with context is keyword", context do
    user1 = %User{id: 1}
    user2 = %User{id: 2}
    user3 = %User{id: 3}

    users = [user1, user2, user3]

    result =
      context.conn
      |> assign(:current_user, user1)
      |> UserView.with_check_keyword(users)

    assert result == [true, false, false]
  end

  test "preloads and check users permissions with context is map", context do
    user1 = %User{id: 1}
    user2 = %User{id: 2}
    user3 = %User{id: 3}

    users = [user1, user2, user3]

    result =
      context.conn
      |> assign(:current_user, user1)
      |> UserView.with_check_map(users)

    assert result == [true, false, false]
  end
end
