defmodule Skeleton.Permission.View do
  defmacro __using__(opts) do
    alias Skeleton.Permission.View

    quote do
      @permission_module unquote(opts[:permission]) || raise("Permission required")

      def preload_permissions(conn, items, permission, permission_names)
          when is_list(permission_names) do
        View.preload_permissions(conn, items, @permission_module, permission, permission_names)
      end

      def preload_permissions(conn, items, permission, permission_name) do
        View.preload_permissions(conn, items, @permission_module, permission, [permission_name])
      end

      # Check permissions

      def check_permission(conn, permission, permission_name) do
        View.check_permission(conn, @permission_module, permission, permission_name, %{})
      end

      def check_permission(conn, permission, permission_name, context)
          when is_map(context) do
        View.check_permission(conn, @permission_module, permission, permission_name, context)
      end

      def check_permission(conn, permission, permission_name, context)
          when is_list(context) do
        View.check_permission(conn, @permission_module, permission, permission_name, Enum.into(context, %{}))
      end
    end
  end

  # Preload permissions

  def preload_permissions(conn, items, permission_module, permission, permission_names) do
    context = permission_module.context(conn)
    permission.preload_data(context, permission_names, items)
  end

  # Check permission

  def check_permission(conn, permission_module, permission, permission_name, context) do
    context =
      conn
      |> permission_module.context()
      |> Map.merge(context)

    permission.check(permission_name, context)
  end
end
