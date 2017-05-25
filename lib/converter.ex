defmodule Converter do
  use Application
  import Ecto.Query

  @moduledoc """
  Documentation for Converter.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Converter.CollectorRepo, []),
      supervisor(Converter.WORepo, [])
    ]

    opts = [strategy: :one_for_one, name: Converter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def convert do
    sermon_series = Converter.CollectorRepo.all(from(ss in "sermon_series", select: {ss.title, ss.description}))
    add_to_wo_db(Enum.at(sermon_series, 0))
    _convert(List.delete_at(sermon_series, 0))
  end

  def _convert([]), do: nil
  def _convert(sermon_series) do
    add_to_wo_db(Enum.at(sermon_series, 0))
    _convert(List.delete_at(sermon_series, 0))
  end

  def add_to_wo_db({title, description}) do
    Converter.WORepo.insert! %WOSermonSeries{title: title, description: description, inserted_at: Ecto.DateTime.utc, updated_at: Ecto.DateTime.utc}
  end
end
