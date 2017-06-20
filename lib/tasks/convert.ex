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
    co_sermon_series = Converter.CollectorRepo.all(from(ss in "sermon_series", select: {ss.id, ss.title, ss.description, ss.passages}, order_by: ss.id))
    insert(co_sermon_series)
  end

  def insert([]), do: nil
  def insert([{co_id, title, description, passages} | tail]) do
    wo_sermon_series = add_sermon_series_to_wo_db({title, description, passages})
    co_sermons = Converter.CollectorRepo.all(from(s in "sermons", select: {s.title, s.description, s.passage}, where: s.sermon_series_id == ^co_id, order_by: s.id))
    Enum.map(co_sermons, fn(s) -> add_sermon_to_wo_db(s, wo_sermon_series.id) end)

    insert(tail)
  end

  def add_sermon_series_to_wo_db({title, description, passages}) do
    if Converter.WORepo.get_by(WOSermonSeries, title: title) == nil do
      Converter.WORepo.insert! %WOSermonSeries{ title: title,
                                                description: description,
                                                passages: passages,
                                                inserted_at: Ecto.DateTime.utc,
                                                updated_at: Ecto.DateTime.utc }
    end
  end

  def add_sermon_to_wo_db({title, description, passage}, sermon_series_id) do
    if Converter.WORepo.get_by(WOSermon, title: title) == nil do
      Converter.WORepo.insert! %WOSermon{ title: title,
                                          description: description,
                                          passages: passage,
                                          sermon_series_id: sermon_series_id,
                                          inserted_at: Ecto.DateTime.utc,
                                          updated_at: Ecto.DateTime.utc }
    end
  end
end
