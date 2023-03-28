import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bloxk, BloxkWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JZK+qPCvVS9cvSZOFd1/seCWvFeEUrt48SAbSdndCgewXIesIVuZWNrpNdo+e+C2",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
