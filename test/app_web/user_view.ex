defmodule Skeleton.AppWeb.UserView do
  use Skeleton.AppWeb, :view
  alias Skeleton.AppWeb.UserPermission

  def with_preload_atom(conn, users) do
    for user <- preload_permissions(conn, users, UserPermission, :can_update) do
      check_permission(conn, UserPermission, :can_update, user: user)
    end
  end

  def with_preload_list(conn, users) do
    for user <- preload_permissions(conn, users, UserPermission, [:can_update]) do
      check_permission(conn, UserPermission, :can_update, user: user)
    end
  end

  def with_check_keyword(conn, users) do
    for user <- preload_permissions(conn, users, UserPermission, :can_update) do
      check_permission(conn, UserPermission, :can_update, user: user)
    end
  end

  def with_check_map(conn, users) do
    for user <- preload_permissions(conn, users, UserPermission, :can_update) do
      check_permission(conn, UserPermission, :can_update, %{user: user})
    end
  end
end
