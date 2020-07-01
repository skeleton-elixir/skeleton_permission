defmodule Skeleton.App.Permission do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission
      import Ecto.Query
      alias Skeleton.App.Repo
    end
  end
end