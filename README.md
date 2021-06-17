# Sobre o Skeleton Permission

O Skeleton Permission ajuda a controlar toda parte de autorização do seu sistema,
seja via `Controller`, `Resolver(Absinthe)`, `View` e `LiveView`.

Além de fornecer a verificação padrão, o Skeleton Permission fornece um mecanismo para realizar
preloads das queries para que não fique custosas(evitando query n+1) as permissões, caso você precise utilizar várias
permissões para vários objetos dentro de um looping.

Outra funcionalidade bastante útil é a permissão por parâmetro. Com ela você consegue filtrar
parametros permitidos diretamente no `Controller` ou `Resolver(Absinthe)`

## Instalação

```elixir
# mix.exs

def deps do
  [
    {:skeleton_phoenix, "~> 2.0.0"},
    {:skeleton_permission, "~> 2.1.1"}
  ]
end
```

```elixir
# lib/app_web/controller.ex

defmodule AppWeb.Controller do
  @behaviour Skeleton.Phoenix.Controller

  defmacro __using__(_) do
    quote do
      use Skeleton.Phoenix.Controller, controller: AppWeb.Controller
      use Skeleton.Permission.Controller, permission: AppWeb.Permission
    end
  end

  def is_authenticated(conn), do: conn.assigns[:current_user]

  def fallback(conn), do: conn
end
```

```elixir
# lib/app_web/view.ex

defmodule AppWeb.View do
  defmacro __using__(_) do
    quote do
      use Skeleton.Permission.View, permission: AppWeb.Permission
    end
  end
end
```

```elixir
# lib/app_web/permission.ex

defmodule AppWeb.Permission do
  @behaviour Skeleton.Permission

  defmacro __using__(_) do
    quote do
      use Skeleton.Permission
      import AppWeb.Permission
      alias App.Repo
    end
  end

  def context(conn) do
    %{
      current_user: conn.assigns[:current_user],
      params: conn.params
    }
  end

  def current_user?(context, user) do
    context.current_user.id == user.id
  end

  def logged_in?(context) do
    not is_nil(context.current_user)
  end

  def is_admin?(context) do
    context.current_user.admin
  end
end
```

## Criando o arquivo de permissão básico

```elixir
defmodule AppWeb.UserPermission do
  use AppWeb.Permission

  def context(conn, _context) do
    %{user: conn.assigns[:user]}
  end

  # Checks

  def check(:can_update, context) do
    logged_in?(context)
    && current_user?(context, context.user)
  end

  # Permits

  def permit(:can_update, context) do
    if check(:can_update, context) && is_admin?(context) do
      context.params
    else
      unpermit(context.params, ["admin"])
    end
  end
end
```

## Criando o arquivo de permissão com preload

```elixir
defmodule AppWeb.UserPermission do
  use AppWeb.Permission
  alias App.User

  def context(conn, _context) do
    %{user: conn.assigns[:user]}
  end

  # Checks

  def check(:can_update, context) do
    logged_in?(context)
    && current_user?(context, context.user)
  end

  def check(:can_join, context) do
    logged_in?(context) && Enum.empty?(context.members)
  end

  # Permits

  def permit(:can_update, context) do
    if check(:can_update, context) && is_admin?(context) do
      context.params
    else
      unpermit(context.params, ["admin"]) # You can use atom(:admin) too
    end
  end

  # Preload

  def preload_data(context, permissions) do
    [user] = do_preload_data(context, permissions, [context.user])
    %{context | user: user}
  end

  def preload_data(context, permissions, users) do
    do_preload_data(context, permissions, users)
  end

  def do_preload_data(context, permissions, users) do
    ids = Enum.map(users, & &1.id)

    User
    |> compose_members(context, permissions)
    |> where([u], u.id in ^ids)
    |> Repo.all()
  end

  defp compose_members(users, %{current_user: nil}, _), do: users
  defp compose_members(users, context, permissions) do
    if include?(permissions, [:can_join]) do
      join(
        :inner, [u], m in assoc(u, :members),
        on: m.user_id == ^context.current_user.id
      )
      |> preload([_u, m], members: m)
    else
      users
    end
  end
end
```