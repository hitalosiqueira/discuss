defmodule Discuss.Blog do
  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Blog.Topic

  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  def create_topic(user, topic_params) do
    user
    |> Ecto.build_assoc(:topics)
    |> Topic.changeset(topic_params)
    |> Repo.insert()
  end

  def list_topics do
    Repo.all(Topic)
  end

  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  def get_topic!(id) do
    Repo.get!(Topic, id)
  end

  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

end
