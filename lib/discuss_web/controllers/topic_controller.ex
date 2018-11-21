defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Blog
  alias Discuss.Blog.Topic

  def new(conn, _params) do
    changeset = Blog.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case Blog.create_topic(topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :new))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "An error occurred.")
        |> render("new.html", changeset: changeset)
    end
  end
end
