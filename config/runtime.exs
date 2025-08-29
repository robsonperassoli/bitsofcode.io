import Config

config :boc, :articles_reloader_enabled, config_env() === :dev
