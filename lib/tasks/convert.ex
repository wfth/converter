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
    sermon_series = Converter.CollectorRepo.all(from(ss in "sermon_series", select: {ss.title, ss.description}))
    Enum.map(sermon_series, fn(ss) -> add_to_wo_db(ss) end)
  end

  def add_to_wo_db({title, description}) do
    if Converter.WORepo.get_by(WOSermonSeries, title: title) == nil do
      Converter.WORepo.insert! %WOSermonSeries{ title: title,
                                                description: description,
                                                inserted_at: Ecto.DateTime.utc,
                                                updated_at: Ecto.DateTime.utc }
    end
  end
end
