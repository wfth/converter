defmodule WOSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :uuid, :string
    field :title, :string
    field :description, :string
    field :passages, :string
    field :released_on_string, :string
    field :graphic_url, :string
    field :buy_graphic_url, :string
    field :price, :float

    timestamps()
  end
end
