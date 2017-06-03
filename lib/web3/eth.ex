defmodule Web3.Eth do
  def coinbase do
    body = call("eth_coinbase")
    cond do
      body["result"] ->
        {:ok, body["result"]}
      body["error"] ->
        {:error, body["error"]}
    end
  end

  defp call(method, params \\ []) do
    data = %{
      :jsonrpc => "2.0",
      :method => method,
      :params => params,
      :id => :rand.uniform(100)
    }
    data_str = ExJSON.generate(data)
    response = HTTPoison.post! "http://localhost:8545", data_str
    ExJSON.parse(response.body, :to_map)
  end
end