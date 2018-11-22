defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn

  alias Discuss.Auth

  def init(_params) do

  end

  def call(conn, _params) do
    with user_id <- get_session(conn, :user_id) do
      if(user_id) do
        user = Auth.get_user(user_id)
        assign(conn, :user, user)
      else
        assign(conn, :user, nil)
      end
    end
  end
end
