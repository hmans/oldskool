# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :oldskool,
  ecto_repos: [Oldskool.Repo]

# Configures the endpoint
config :oldskool, Oldskool.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fLW155kkaXBb2kH0aSMH4f0WIY+DggzGtSOfbuTYk0QL0MfL2BZyIgOhBC8jdyad",
  render_errors: [view: Oldskool.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Oldskool.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Use Slime for templates
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Überauth
config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [default_scope: ""] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
