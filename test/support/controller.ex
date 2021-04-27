defmodule Skeleton.App.Controller do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission.Controller
    end
  end
end
