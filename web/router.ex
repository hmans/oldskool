defmodule Oldskool.Router do
  use Oldskool.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Oldskool.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Oldskool do
    pipe_through :browser # Use the default browser stack
    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Oldskool do
  #   pipe_through :api
  # end
end
