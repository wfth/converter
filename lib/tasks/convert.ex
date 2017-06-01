defmodule Mix.Tasks.Converter.Convert do
  use Mix.Task
  import Mix.Ecto
  import Ecto.Query

  def run(args) do
    repos = parse_repo(args)

    Enum.each repos, fn repo ->
      ensure_started(repo, [])
    end

    convert()
  end

  def convert do
    sermon_series = Converter.CollectorRepo.all(from(ss in "sermon_series", select: {ss.id, ss.title, ss.description}))
    insert(sermon_series)
  end

  def insert([]), do: nil
  def insert([{id, title, description} | tail]) do
    add_sermon_series_to_wo_db({title, description})
    sermons = Converter.CollectorRepo.all(from(s in "sermons", select: {s.title, s.description, s.passage}, where: s.sermon_series_id == ^id))
    Enum.map(sermons, fn(s) -> add_sermon_to_wo_db(s, id) end)

    insert(tail)
  end

  def add_sermon_series_to_wo_db({title, description}) do
    if Converter.WORepo.get_by(WOSermonSeries, title: title) == nil do
      Converter.WORepo.insert! %WOSermonSeries{ title: title,
                                                description: description,
                                                inserted_at: Ecto.DateTime.utc,
                                                updated_at: Ecto.DateTime.utc }
    end
  end

  def add_sermon_to_wo_db({title, description, passage}, sermon_series_id) do
    if Converter.WORepo.get_by(WOSermon, title: title) == nil do
      Converter.WORepo.insert! %WOSermon{ title: title,
                                          description: description,
                                          passage: passage,
                                          sermon_series_id: sermon_series_id,
                                          inserted_at: Ecto.DateTime.utc,
                                          updated_at: Ecto.DateTime.utc }
    end
  end
end
