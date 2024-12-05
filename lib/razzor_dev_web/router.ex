defmodule RazzorDevWeb.Router do
  use RazzorDevWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RazzorDevWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RazzorDevWeb do
    pipe_through :browser

    live "/", HomeLive
  end

  scope "/blog", RazzorDevWeb do
    pipe_through :browser

    get "/", PostController, :index
    get "/:slug", PostController, :show
    get "/new", PostController, :new
    post "/", PostController, :create
    get "/:slug/edit", PostController, :edit
    patch "/:slug", PostController, :update
    delete "/:slug", PostController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", RazzorDevWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:razzor_dev, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RazzorDevWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
