defmodule Web3.Eth do
  use Web3.Rpc, prefix: "eth"

  defrpc coinbase()
  defrpc getBalance(address, blockNumber)
  defrpc accounts()
  defrpc blockNumber()
  defrpc gasPrice()
  defrpc hashrate()
  defrpc mining()
  defrpc syncing()
  defrpc protocolVersion()
  defrpc getStorageAt(address, position, blockNumber)
  defrpc getTransactionCount(address, blockNumber)
  defrpc getBlockTransactionCountByHash(blockHash)
  defrpc getBlockTransactionCountByNumber(blockNumber)
  defrpc getCode(address, blockNumber)
  defrpc sign(address, dataToSign)
  defrpc sendTransaction(object)
  defrpc call(object, blockNumber)
  defrpc estimateGas(object, blockNumber)
  defrpc getBlockByHash(blockHash, returnTransactionObjects)
  defrpc getBlockByNumber(blockNumber, return_transaction_objects)
  defrpc getTransaction(hash)
  defrpc getTransactionByBlockHashAndIndex(blockHash, index)
  defrpc newFilter(object)
  defrpc newBlockFilter()
  defrpc newPendingTransactionFilter()
  defrpc uninstallFilter()
  defrpc getFilterChanges(filterId)
  defrpc getFilterLogs(filterId)
  defrpc getLogs(object)

  def getTransactionsByBlockHash(blockHash) do
    with {:ok, block} <- getBlockByHash(blockHash, true)
    do
      {:ok, block["transactions"] |> Enum.map(&(&1["hash"]))}
    else
      error -> error
    end
  end

  def getTransactionsByBlockHashs(blockHashs) do
    blockHashs
    |> Enum.map(&(get_transactions(&1)))
    |> Enum.concat()
  end

  # private -----------------------------------------------------------------
  defp get_transactions(block_hash) do
    with {:ok, transactions} <- Web3.Eth.getTransactionsByBlockHash(block_hash)
    do
      transactions
    else
      error -> []
    end
  end

end