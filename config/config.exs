# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
    # config :web3, receive_transaction_cmd: """
    # curl -i -u admin:ed018608 -H "content-type:application/json" -X POST \
    # -d '{"properties":{},"routing_key":"peatio.deposit.coin","payload":"<transaction>","payload_encoding":"string"}' \
    # http://localhost:5672/api/exchanges/%2f//publish
    # """

    # config :web3, receive_transaction_cmd: """
    # echo "<transaction>"
    # """

    config :web3, node_url: "http://localhost:8545"
    # config :web3, node_url: "http://116.62.16.229:30803"

#
# And access this configuration in your application as:
#
#     Application.get_env(:web3, :key)
#
# Or configure a 3rd-party app:
#
    # config :logger, :file_log, path: "./filter.log", level: :info
    config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
