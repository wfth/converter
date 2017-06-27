defmodule CollectorSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :title, :string
    field :description, :string
    field :passages, :string
    field :released_on, :string
    field :graphic_key, :string
    field :buy_graphic_key, :string
    field :price, :float
  end
end
