defmodule CollectorSermon do
  use Ecto.Schema

  schema "sermons" do
    field :title, :string
    field :description, :string
    field :passage, :string
    field :audio_key, :string
    field :transcript_key, :string
    field :transcript_text, :string
    field :buy_graphic_key, :string
    field :price, :float
  end
end
