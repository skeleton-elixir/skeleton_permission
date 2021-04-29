defmodule Skeleton.AppWeb.Controller do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission.Controller, permission: Skeleton.AppWeb.Permission
    end
  end
end
