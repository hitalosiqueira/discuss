defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug Ueberauth

  alias Discuss.Auth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider})do
    user_params = %{email: auth.info.email, provider: provider, token: auth.credentials.token}

    case Auth.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome Back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "An error occurred")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end
end
