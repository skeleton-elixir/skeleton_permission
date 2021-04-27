defmodule Skeleton.App.UserController do
  use Skeleton.App.Controller
  alias Skeleton.App.UserPermission

  def update(conn) do
    conn
    |> check_permission(UserPermission, :can_update)
    |> permit_params(UserPermission, :can_update)
  end

  def unauthenticated_update(conn) do
    conn
  end
end
