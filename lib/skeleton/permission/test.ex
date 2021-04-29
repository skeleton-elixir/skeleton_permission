defmodule Skeleton.Permission.Test do
  def check_permission(context, permission, permission_name) do
    context = permission.preload_data(context, [permission_name])
    permission.check(permission_name, context)
  end
end
