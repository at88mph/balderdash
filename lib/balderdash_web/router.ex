defmodule BalderdashWeb.Router do
  use BalderdashWeb, :router

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

  scope "/", BalderdashWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/question/:id", QuestionController, :show
    get "/question/edit/:id", QuestionController, :edit
    put "/question/:id", QuestionController, :update
    delete "/question/:id", QuestionController, :delete

    get "/questions/rando/:count", QuestionController, :random
    get "/questions", QuestionController, :index
    get "/question", QuestionController, :new
    post "/question", QuestionController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", BalderdashWeb do
  #   pipe_through :api
  # end
end
