defmodule Skeleton.Permission.Test do
  def check_permission(context, permission_module, permission_name) do
    context = permission_module.preload_data(context, [permission_name])
    permission_module.check(permission_name, context)
  end
end
