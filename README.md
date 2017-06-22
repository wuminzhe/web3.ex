# web3.ex

Ethereum Elixir API

## Api list

The apis from official rpc, read official [JSON RPC API](https://github.com/ethereum/wiki/wiki/JSON-RPC) document for more details:
```
Web3.Eth.coinbase()
Web3.Eth.getBalance(address, blockNumber)
Web3.Eth.accounts()
Web3.Eth.blockNumber()
Web3.Eth.gasPrice()
Web3.Eth.hashrate()
Web3.Eth.mining()
Web3.Eth.syncing()
Web3.Eth.protocolVersion()
Web3.Eth.getStorageAt(address, position, blockNumber)
Web3.Eth.getTransactionCount(address, blockNumber)
Web3.Eth.getBlockTransactionCountByHash(blockHash)
Web3.Eth.getBlockTransactionCountByNumber(blockNumber)
Web3.Eth.getCode(address, blockNumber)
Web3.Eth.sign(address, dataToSign)
Web3.Eth.sendTransaction(object)
Web3.Eth.call(object, blockNumber)
Web3.Eth.estimateGas(object, blockNumber)
Web3.Eth.getBlockByHash(blockHash, returnTransactionObjects)
Web3.Eth.getBlockByNumber(blockNumber, return_transaction_objects)
Web3.Eth.getTransaction(hash)
Web3.Eth.getTransactionByBlockHashAndIndex(blockHash, index)
Web3.Eth.newFilter(object)
Web3.Eth.newBlockFilter()
Web3.Eth.newPendingTransactionFilter()
Web3.Eth.uninstallFilter()
Web3.Eth.getFilterChanges(filterId)
Web3.Eth.getFilterLogs(filterId)
Web3.Eth.getLogs(object)
```

The apis added by web3.ex
```
Web3.Eth.getTransactionsByBlockHash(blockHash)
Web3.Eth.getTransactionsByBlockHashs(blockHashs)
```

## Installation

by adding `web3` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:web3, git: "ssh://git@gitlab.chainresearch.org:50022/exchange/web3.ex.git"}]
end
```
