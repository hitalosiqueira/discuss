defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Blog
  alias Discuss.Blog.Topic

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def new(conn, _params) do
    changeset = Blog.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    user = conn.assigns.user
    case Blog.create_topic(user, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "An error occurred.")
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    with topics <- Blog.list_topics do
      conn
      |> render("index.html", topics: topics)
    end
  end

  def edit(conn, %{"id" => id}) do
    with topic <- Blog.get_topic!(id),
         changeset <- Blog.change_topic(topic) do
      render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "topic"=>topic_params})do
    topic = Blog.get_topic!(id)

    case Blog.update_topic(topic, topic_params)do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "An error occurred")
        |> render("edit.html", changeset: changeset, topic: topic)
    end

  end
  def delete(conn, %{"id" => id}) do
    with topic <- Blog.get_topic!(id), {:ok, _topic} <- Blog.delete_topic(topic) do
      conn
      |> put_flash(:info, "Topic deleted successfully")
      |> redirect(to: topic_path(conn, :index))
    end
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Blog.get_topic!(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You shall not pass!")
      |> redirect(to: topic_path(conn, :index))
      |> halt()

    end
  end
end
