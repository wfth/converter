defmodule WOSermon do
  use Ecto.Schema

  schema "sermons" do
    field :uuid, :string
    field :title, :string
    field :description, :string
    field :passages, :string
    field :sermon_series_id, :integer
    field :audio_url, :string
    field :buy_graphic_url, :string
    field :price, :float
    field :transcript_url, :string
    field :transcript_text, :string

    timestamps()
  end
end
