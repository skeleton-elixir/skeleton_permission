defmodule Skeleton.Permission do
  @callback context(Any.t()) :: Map.t()

  defmacro __using__(_opts) do
    quote do
      import Skeleton.Permission

      def context(_), do: %{}

      def check(_, _), do: false

      def permit(_, context), do: context

      defoverridable context: 1, check: 2, permit: 2
    end
  end

  def unpermit(params, unpermitted) do
    string_params = Enum.map(unpermitted, &to_string/1)

    params
    |> Map.drop(string_params)
    |> Map.drop(Enum.map(string_params, &String.to_atom/1))
  end

  def include?(a, b) do
    length(a -- a -- b) > 0
  end
end
