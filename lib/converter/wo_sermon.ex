defmodule WOSermon do
  use Ecto.Schema

  schema "sermons" do
    field :title, :string
    field :passage, :string
    field :sermon_series_id, :integer

    timestamps()
  end
end
