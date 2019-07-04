# AppmanDep
This project is needed as a dependency to enable Appman to run the application.

## Installation
```elixir
def deps do
  [
    {:appman_dep, "~> 0.1.0"}
  ]
end
```

## Configuration
Add the following to your config file to enable logging:
```elixir
config :logger,
  backends: [{LoggerFileBackend, :default_log}]

config :logger, :default_log,
  path: "/var/log/appman/default.log",
  level: :debug
```