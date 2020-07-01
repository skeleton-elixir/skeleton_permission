defmodule Skeleton.App.UserPermission do
  use Skeleton.App.Permission

  def check(:can_update, context) do
    context.current_user && context.current_user.id == context.resource.id
  end

  def permit(:can_update, context) do
    if check(:can_update, context) && context.current_user.admin do
      context.params
    else
      unpermit(context.params, ["admin"])
    end
  end

  # def preload(_permission_name, _context, params) do
  #   Skeleton.Phoenix.User
  #   |> where([u], u.id == ^params[:id])
  #   |> Repo.all()
  # end
end
