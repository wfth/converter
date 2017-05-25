defmodule WOSermonSeries do
  use Ecto.Schema

  schema "sermonseries" do
    field :title, :string
    field :description, :string

    timestamps()
  end
end
