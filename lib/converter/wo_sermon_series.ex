defmodule WOSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :title, :string
    field :description, :string

    timestamps()
  end
end
