# AppmanDep
This project is needed as a dependency to enable Appman **https://github.com/AntonChernev/appman** to run the application.

## Installation
```elixir
def deps do
  [
    {:appman_dep, git: "https://github.com/AntonChernev/appman_dep"}
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