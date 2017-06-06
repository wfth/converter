defmodule CollectorSermonSeries do
  use Ecto.Schema

  schema "sermon_series" do
    field :title, :string
    field :description, :string
    field :passages, :string
  end
end
