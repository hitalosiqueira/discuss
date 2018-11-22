defmodule Discuss.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Blog.Topic

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string

    has_many :topics, Topic

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
