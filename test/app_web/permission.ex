defmodule Skeleton.AppWeb.Permission do
  @behaviour Skeleton.Permission

  defmacro __using__(_) do
    quote do
      use Skeleton.Permission
    end
  end

  def context(conn) do
    %{
      current_user: conn.assigns[:current_user],
      params: conn.params
    }
  end
end
