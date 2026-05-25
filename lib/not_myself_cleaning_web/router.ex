defmodule NotMyselfCleaningWeb.Router do
  use Phoenix.Router
  import Plug.Conn
  import Phoenix.Controller

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:load_current_user)
  end

  scope "/", NotMyselfCleaningWeb do
    pipe_through(:browser)

    get("/health", AuthController, :health)
    get("/", AuthController, :home)
    get("/register", AuthController, :register_page)
    post("/register", AuthController, :register)
    get("/login", AuthController, :login_page)
    post("/login", AuthController, :login)
    post("/logout", AuthController, :logout)

    get("/requests", RequestController, :index)
    get("/requests/new", RequestController, :new)
    post("/requests", RequestController, :create)

    get("/admin", AdminController, :index)
    post("/admin/status", AdminController, :update_status)
  end

  defp load_current_user(conn, _opts) do
    case get_session(conn, :session_token) do
      nil ->
        assign(conn, :current_user, nil)

      token ->
        case NotMyselfCleaning.Accounts.get_session(token) do
          nil ->
            conn
            |> delete_session(:session_token)
            |> assign(:current_user, nil)

          session ->
            assign(conn, :current_user, session)
        end
    end
  end
end
