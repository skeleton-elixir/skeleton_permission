defmodule Skeleton.AppWeb.View do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission.View, permission: Skeleton.AppWeb.Permission
    end
  end
end
