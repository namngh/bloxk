defmodule BloxkWeb.Router do
  use BloxkWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BloxkWeb do
    pipe_through :api
  end
end
