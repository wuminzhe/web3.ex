defmodule Web3 do
  use Application

  def start(_type, _args) do

    import Supervisor.Spec
    children = [
      worker(Task, [Web3.Filter, :watch, []])
    ]

    opts = [strategy: :one_for_one, name: Web3.Filter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end


