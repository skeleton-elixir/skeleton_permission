defmodule Skeleton.Permission.LiveView do
  # Callbacks

  defmacro __using__(opts) do
    alias Skeleton.Permission.LiveView

    quote do
      @permission_module unquote(opts[:permission]) || raise("Permission required")

      def check_permission({:error, socket, error}, _, _, _), do: {:error, socket, error}

      def check_permission(socket, permission, permission_name, ctx_fun) do
        LiveView.do_check_permission(
          socket,
          @permission_module,
          permission,
          permission_name,
          ctx_fun
        )
      end

      def check_permission({:error, socket, error}, _, _), do: {:error, socket, error}

      def check_permission(socket, permission, permission_name) do
        LiveView.do_check_permission(
          socket,
          @permission_module,
          permission,
          permission_name,
          fn _, ctx ->
            ctx
          end
        )
      end
    end
  end

  # Do check permission

  def do_check_permission(socket, permission_module, permission, permission_name, ctx_fun) do
    context =
      socket
      |> build_permission_context(permission_module, permission, ctx_fun)
      |> permission.preload_data([permission_name])

    if permission.check(permission_name, context) do
      socket
    else
      unauthorized(socket)
    end
  end

  # Do build context

  def build_permission_context(socket, permission_module, permission, ctx_fun) do
    default_context = permission_module.context(socket)
    permission_context = permission.context(socket, default_context)

    ctx_fun.(socket, Map.merge(default_context, permission_context))
  end

  # Return unauthorized

  def unauthorized(socket) do
    {:error, socket, :unauthorized}
  end

  def forbidden(socket) do
    {:error, socket, :forbidden}
  end
end
