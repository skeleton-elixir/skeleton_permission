defmodule Skeleton.AppWeb.UserPermission do
  use Skeleton.AppWeb.Permission

  def context(conn, _context) do
    %{user: conn.assigns[:user]}
  end

  def check(:can_update, context) do
    context.current_user && context.current_user.id == context.user.id
  end

  def permit(:can_update, context) do
    if check(:can_update, context) && context.current_user.admin do
      context.params
    else
      unpermit(context.params, ["admin"])
    end
  end
end
