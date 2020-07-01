defmodule Skeleton.App.TestCase do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Skeleton.App.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Skeleton.App.Repo, {:shared, self()})
  end
end

Skeleton.App.Repo.start_link()
Ecto.Adapters.SQL.Sandbox.mode(Skeleton.App.Repo, :manual)

ExUnit.start()
