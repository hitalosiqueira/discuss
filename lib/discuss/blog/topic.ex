defmodule Discuss.Blog.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Auth.User

  schema "topics" do
    field :title, :string
    field :description, :string

    belongs_to :user, User #BELONGS TO SEMPRE SINGULAR :USER

    timestamps()
  end

  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
