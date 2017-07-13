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
    co_sermon_series = Converter.CollectorRepo.all(from(ss in "sermon_series",
          select: {ss.id, ss.title, ss.description, ss.passages, ss.released_on, ss.graphic_key, ss.buy_graphic_key, ss.price}, order_by: ss.id))
    insert(co_sermon_series)
  end

  def insert([]), do: nil
  def insert([{co_id, title, description, passages, released_on, graphic_key, buy_graphic_key, price} | tail]) do
    wo_sermon_series = add_sermon_series_to_wo_db({title, description, passages, released_on, graphic_key, buy_graphic_key, price})
    co_sermons = Converter.CollectorRepo.all(from(s in "sermons",
          select: {s.title, s.description, s.passage, s.audio_key, s.transcript_key, s.transcript_text, s.buy_graphic_key, s.price},
          where: s.sermon_series_id == ^co_id,
          order_by: s.id))
    Enum.map(co_sermons, fn(s) -> add_sermon_to_wo_db(s, wo_sermon_series.id) end)

    insert(tail)
  end

  def add_sermon_series_to_wo_db({title, description, passages, released_on, graphic_key, buy_graphic_key, price}) do
    if Converter.WORepo.get_by(WOSermonSeries, title: title) == nil do
      Converter.WORepo.insert! %WOSermonSeries{ uuid: uuid(graphic_key),
                                                title: title,
                                                description: description,
                                                passages: passages,
                                                released_on_string: released_on,
                                                graphic_url: url_from_key(graphic_key),
                                                buy_graphic_url: url_from_key(buy_graphic_key),
                                                price: price,
                                                inserted_at: Ecto.DateTime.utc,
                                                updated_at: Ecto.DateTime.utc }
    end
  end

  def add_sermon_to_wo_db({title, description, passage, audio_key, transcript_key, transcript_text, buy_graphic_key, price}, sermon_series_id) do
    if Converter.WORepo.get_by(WOSermon, title: title) == nil do
      Converter.WORepo.insert! %WOSermon{ uuid: uuid(audio_key),
                                          title: title,
                                          description: description,
                                          passages: passage,
                                          sermon_series_id: sermon_series_id,
                                          audio_url: url_from_key(audio_key),
                                          buy_graphic_url: url_from_key(buy_graphic_key),
                                          transcript_url: url_from_key(transcript_key),
                                          transcript_text: transcript_text,
                                          price: price,
                                          inserted_at: Ecto.DateTime.utc,
                                          updated_at: Ecto.DateTime.utc }
    end
  end

  def uuid(nil), do: Ecto.UUID.generate()
  def uuid(key) do
    key |> String.split("/") |> Enum.at(1)
  end

  def url_from_key(nil), do: nil
  def url_from_key(key) do
    "https://s3.amazonaws.com/wisdomonline-development/" <> String.replace(key, " ", "+")
  end
end
