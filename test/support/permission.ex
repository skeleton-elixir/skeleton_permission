defmodule Skeleton.App.Permission do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission
    end
  end
end
