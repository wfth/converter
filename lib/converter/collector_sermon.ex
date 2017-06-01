defmodule CollectorSermon do
  use Ecto.Schema

  schema "sermons" do
    field :title, :string
    field :description, :string
    field :passage, :string
  end
end
