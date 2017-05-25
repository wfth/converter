defmodule Converter do
  use Application

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
end
