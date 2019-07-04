defmodule AppmanDep.Application do
  use Application

  def start(_type, _args) do
    log_path =
      "/var/log/appman/" <>
        (Node.self() |> to_string() |> String.split("@") |> List.first()) <>
        ".log"

    Logger.configure_backend(
      {LoggerFileBackend, :default_log},
      path: log_path
    )

    children = [
      {AppmanDep.Connector, []}
    ]

    opts = [strategy: :one_for_one, name: AppmanDep.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
