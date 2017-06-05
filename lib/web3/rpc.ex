defmodule Web3.Rpc do

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