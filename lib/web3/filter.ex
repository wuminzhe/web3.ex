defmodule Web3.Filter do
  require Logger

  @cmd Application.get_env(:web3, :receive_transaction_cmd)

  def watch do
    with {:ok, filter_id} <- Web3.Eth.newBlockFilter()
    do
      do_watch(filter_id)
    end
  end

  def do_watch(filter_id) do
    Logger.debug(filter_id)
    with {:ok, block_hashs} <- Web3.Eth.getFilterChanges(filter_id),
         {:ok, transactions} <- Web3.Eth.getTransactionsByBlockHashs(block_hashs),
         {:ok, transactions} <- my(transactions)
    do
      Enum.each transactions, fn(transaction) ->
        # -i -u admin:ed018608 -H "content-type:application/json" -X POST -d '{"properties":{},"routing_key":"peatio.normal","payload":"{\"txid\":\"0xc2a5f8f873ecff74542da7a7124a577e9525ab3dc9bc8ebfb45ddc95f41e0aa0\", \"channel_key\":\"satoshi\"}","payload_encoding":"string"}' http://localhost:15672/api/exchanges/%2f//publish
        System.cmd("curl", ["-i", "-u admin:ed018608", "-H \"content-type:application/json\"", "-X POST", "-d {'properties':{},'routing_key':'peatio.normal','payload':'{\"txid\":\"0xc2a5f8f873ecff74542da7a7124a577e9525ab3dc9bc8ebfb45ddc95f41e0aa0\", \"channel_key\":\"satoshi\"}','payload_encoding':'string'}", "http://localhost:15672/api/exchanges/%2f//publish"])
      end
    else
      error -> Logger.error(error)
    end

    :timer.sleep 5000
    
    do_watch(filter_id)
  end

  # private -----------------------------------------------------------------
  
  defp my(transactions) do
    with {:ok, accounts} <- Web3.Eth.accounts()
    do
      # IO.puts is_list(transactions)
      { :ok, transactions |> Enum.filter( &(Enum.member?(accounts, &1["to"]) ) ) }
    else
      error -> error
    end
  end

end