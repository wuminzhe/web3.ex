defmodule Web3.Filter do

  def watch do
    with {:ok, filter_id} <- Web3.Eth.newBlockFilter()
    do
      
    end

  end

  def do_watch(filter_id) do

    with {:ok, block_hashs} <- Web3.Eth.getFilterChanges(filter_id)
         {:ok, transactions} <- Web3.Eth.getTransactionsByBlockHashs(block_hashs)
         {:ok, transactions} <- my(transactions)
    do
      transactions.each fn(transaction) ->
        IO.puts transaction["hash"]
      end
    end

    :timer.sleep 5000
    
    do_watch(filter_id)
  end

  
  defp my(transactions) do
    with {:ok, accounts} <- Web3.Eth.eth_accounts()
    do
      transactions |> Enum.filter( &(Enum.member?(accounts, &1["to"]) )
    else
      error -> error
    end
  end

end