defmodule Skeleton.AppWeb.UserController do
  use Skeleton.AppWeb, :controller
  alias Skeleton.AppWeb.UserPermission

  def update(conn) do
    conn
    |> check_permission(UserPermission, :can_update)
    |> permit_params(UserPermission, :can_update)
  end

  def unauthenticated_update(conn) do
    conn
  end
end
