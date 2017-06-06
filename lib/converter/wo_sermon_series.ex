defmodule WOSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :title, :string
    field :description, :string
    field :passages, :string

    timestamps()
  end
end
