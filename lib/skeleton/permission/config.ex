defmodule Skeleton.Permission.Config do
  def permission, do: config(:permission)

  def config(key, default \\ nil) do
    Application.get_env(:skeleton_permission, key, default)
  end
end