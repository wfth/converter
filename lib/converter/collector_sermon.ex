defmodule CollectorSermon do
  use Ecto.Schema

  schema "sermons" do
    field :title, :string
    field :passage, :string
  end
end
