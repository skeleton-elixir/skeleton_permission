defmodule Skeleton.PermissionTest do
  use Skeleton.App.TestCase
  alias Skeleton.App.{User, UserPermission}

  describe "check permittion" do
    test "when it's permitted" do
      context = %{
        current_user: %User{id: 123},
        resource: %User{id: 123}
      }

      assert UserPermission.check(:can_update, context)
    end

    test "when isn't permitted" do
      context = %{
        current_user: %User{id: 123},
        resource: %User{id: 321}
      }

      refute UserPermission.check(:can_update, context)
    end
  end

  describe "permit params" do
    test "when it's permitted" do
      context = %{
        current_user: %User{id: 123, admin: true},
        resource: %User{id: 123},
        params: %{
          name: "my name",
          email: "email@email.com",
          admin: true
        }
      }

      params = UserPermission.permit(:can_update, context)

      assert params[:name] == "my name"
      assert params[:email] == "email@email.com"
      assert params[:admin]
    end

    test "when isn't permitted" do
      context = %{
        current_user: %User{id: 123},
        resource: %User{id: 123},
        params: %{
          name: "my name",
          email: "email@email.com",
          admin: true
        }
      }

      params = UserPermission.permit(:can_update, context)

      assert params[:name] == "my name"
      assert params[:email] == "email@email.com"
      refute params[:admin]
    end
  end
end
