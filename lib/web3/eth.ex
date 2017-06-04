defmodule Web3.Eth do
  require OK

  def coinbase do
    invoke("eth_coinbase")
  end

  def get_balance(address, block_number \\ "latest") do
    OK.with do
      result <- invoke("eth_getBalance", [address, block_number])
      Web3.Hex.to_int(result)
    end
  end

  def accounts do
    invoke("eth_accounts")
  end

  def block_number do
    OK.with do
      number <- invoke("eth_blockNumber")
      Web3.Hex.to_int(number)
    end
  end

  def gas_price do
    OK.with do
      result <- invoke("eth_gasPrice")
      Web3.Hex.to_int(result)
    end
  end

  def hashrate do
    OK.with do
      result <- invoke("eth_hashrate")
      Web3.Hex.to_int(result)
    end
  end

  def mining do
    invoke("eth_mining")
  end

  # TODO: when result is not false, convert hex to int
  def syncing do
    invoke("eth_syncing")
  end

  def protocol_version do
    OK.with do
      result <- invoke("eth_protocolVersion")
      Web3.Hex.to_int(result)
    end
  end

  def get_storage_at(address, position, block_number \\ "latest") do
    invoke("eth_protocolVersion", [address, position, block_number])
  end

  def get_transaction_count(address, block_number \\ "latest") do
    OK.with do
      result <- invoke("eth_getTransactionCount", [address, block_number])
      Web3.Hex.to_int(result)
    end
  end

  # TODO
  def get_block_transaction_count(hash_or_block_bumber) do
    if Web3.is_address?(hash_or_block_bumber) do
      invoke("eth_getBlockTransactionCountByHash", [hash_or_block_bumber])
    else
      invoke("eth_getBlockTransactionCountByNumber", [hash_or_block_bumber])
    end
  end

  # def get_block_uncle_count(hash_or_block_bumber) do
    
  # end

  def get_code(address, block_number \\ "latest") do
    invoke("eth_getCode", [address, block_number])
  end

  # def getBlockTransactionCount(blockNumber) when not Web3.Hex.is_hex?(blockNumber) do
    
  # end

  def sign(address, data_to_sign) do
    invoke("eth_sign", [address, data_to_sign])
  end

  def send_transaction(object) do
    invoke("eth_sendTransaction", [object])
  end

  def call(object, block_number \\ "latest") do
    invoke("eth_sendTransaction", [object, block_number])
  end

  def estimate_gas(object, block_number \\ "latest") do
    invoke("eth_estimateGas", [object, block_number])
  end

  def get_block_by_hash(hash, return_transaction_objects) do
    invoke("eth_getBlockByHash", [hash, return_transaction_objects])
  end

  def get_block_by_number(number, return_transaction_objects) do
    invoke("eth_getBlockByNumber", [number, return_transaction_objects])
  end

  def get_transaction(hash) do
    invoke("eth_sendTransaction", [hash])
  end

  def get_transaction_by_block_hash_and_index(block_hash, index) do
    
  end

  defp invoke(method, params \\ []) do
    data = %{
      :jsonrpc => "2.0",
      :method => method,
      :params => params,
      :id => :rand.uniform(100)
    }
    data_str = ExJSON.generate(data)
    response = HTTPoison.post! "http://localhost:8545", data_str

    # IO.puts response.body
    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        obj = ExJSON.parse(body, :to_map)
        cond do
          obj["result"] != nil ->
            {:ok, obj["result"]}
          obj["error"] != nil ->
            {:error, obj["error"]}
        end
      %HTTPoison.Response{status_code: code} ->
        {:error, code}
    end
    
  end
end