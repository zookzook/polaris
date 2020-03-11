defmodule PolarisWeb.Router do
  use PolarisWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PolarisWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/index.html", PageController, :index
    get ":section/:file", PageController, :section
  end

  # Other scopes may use custom stacks.
  # scope "/api", PolarisWeb do
  #   pipe_through :api
  # end
end
