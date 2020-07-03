defmodule Skeleton.ConfigTest do
  use Skeleton.App.TestCase
  alias Skeleton.Permission.Config
  alias Skeleton.App.Permission

  test "returns permission module" do
    assert Config.permission() == Permission
  end
end