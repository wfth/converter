defmodule CollectorSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :title, :string
    field :description, :string
  end
end
