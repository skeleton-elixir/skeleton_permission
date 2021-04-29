defmodule Skeleton.AppWeb do
  def controller do
    quote do
      use Skeleton.AppWeb.Controller
    end
  end

  def view do
    quote do
      use Skeleton.AppWeb.View
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
