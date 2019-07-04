use Mix.Config

config :logger,
  backends: [{LoggerFileBackend, :default_log}]

config :logger, :default_log,
  path: "/var/log/appman/default.log",
  level: :debug
