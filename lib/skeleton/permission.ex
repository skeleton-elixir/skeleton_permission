defmodule Skeleton.Permission do
  defmacro __using__(_opts) do
    quote do
      import Skeleton.Permission

      def check(_, _), do: false

      def permit(_, context), do: context

      defoverridable check: 2, permit: 2
    end
  end

  def unpermit(params, unpermitted) do
    string_params = Enum.map(unpermitted, &to_string/1)

    params
    |> Map.drop(string_params)
    |> Map.drop(Enum.map(string_params, &String.to_atom/1))
  end
end
