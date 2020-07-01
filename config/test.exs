use Mix.Config

config :skeleton_permission, ecto_repos: [Skeleton.App.Repo]

config :skeleton_permission, Skeleton.App.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "skeleton_permission_test",
  username: System.get_env("SKELETON_PERMISSION_DB_USER") || System.get_env("USER") || "postgres"

config :logger, :console, level: :error

config :skeleton_permission, permission: Skeleton.App.Permission