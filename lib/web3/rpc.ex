defmodule Web3.Rpc do
  require Logger

  defmacro __using__([prefix: prefix]) do
    quote do
      @prefix unquote(prefix)
      import Web3.Rpc
    end
  end

  defmacro defrpc(function) do
    {method, _, params} = function
    quote do
      def unquote(function) do
        rpc_name = "#{@prefix}_#{unquote(method)}"
        Web3.Rpc.invoke(rpc_name, unquote(params))
      end
    end
  end

  def invoke(method, params \\ []) do
    data = [
      jsonrpc: "2.0",
      method: method,
      params: params,
      id: :rand.uniform(100)
    ]
    data_str = elem(JSON.encode(data), 1)
    # IO.puts data_str
    response = HTTPoison.post! "http://localhost:8545", data_str, [{"Content-Type", "application/json"}]

    Logger.info Application.get_env(:web3, :node_url)
    # IO.puts response.body
    case response do
      %HTTPoison.Response{status_code: 200, body: body} ->
        obj = elem(JSON.decode(body), 1)
        case obj do
          %{"jsonrpc" => "2.0", "result" => nil} ->
            {:error, "Not Found"}
          %{"jsonrpc" => "2.0", "result" => result} ->
            {:ok, result}
          %{"jsonrpc" => "2.0", "error" => error} ->
            {:error, error}
        end
      %HTTPoison.Response{status_code: code} ->
        {:error, code}
    end

  end
end
