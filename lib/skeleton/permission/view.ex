defmodule Skeleton.Permission.View do
  alias Skeleton.Permission.Config

  defmacro __using__(_) do
    alias Skeleton.Permission.View

    quote do
      # Preload permissions

      def preload_permissions(conn, items, permission_module, permission_names)
          when is_list(permission_names) do
        View.preload_permissions(conn, items, permission_module, permission_names)
      end

      def preload_permissions(conn, items, permission_module, permission_name) do
        View.preload_permissions(conn, items, permission_module, [permission_name])
      end

      # Check permissions

      def check_permission(conn, permission_module, permission_name) do
        View.check_permission(conn, permission_module, permission_name, %{})
      end

      def check_permission(conn, permission_module, permission_name, context)
          when is_map(context) do
        View.check_permission(conn, permission_module, permission_name, context)
      end

      def check_permission(conn, permission_module, permission_name, context)
          when is_list(context) do
        View.check_permission(conn, permission_module, permission_name, Enum.into(context, %{}))
      end
    end
  end

  # Preload permissions

  def preload_permissions(conn, items, permission_module, permission_names) do
    context = Config.permission().context(conn)
    permission_module.preload_data(context, permission_names, items)
  end

  # Check permission

  def check_permission(conn, permission_module, permission_name, context) do
    context =
      conn
      |> Config.permission().context()
      |> Map.merge(context)

    permission_module.check(permission_name, context)
  end
end
