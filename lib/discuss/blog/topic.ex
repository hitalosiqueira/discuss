defmodule Discuss.Blog.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    field :description, :string

    timestamps()
  end

  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
