defmodule WoSermonSeries do
  use Ecto.Schema

  schema "sermonseries" do
    field :title, :string
    field :description, :string
  end
end
