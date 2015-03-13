defmodule Phoenix.HTTPClient do
  require Logger

  @doc """
  Performs HTTP Request and returns Response

    * method - The http methid, ie :get, :post, :put, etc
    * url - The string url, ie "http://example.com"
    * headers - The map of headers
    * body - The optional string body. If the body is a map, it is convered
             to a URI encoded string of parameters

  ## Examples

      iex> HTTPClient.request(:get, "http://127.0.0.1", %{})
      {:ok, %Response{..})

      iex> HTTPClient.request(:post, "http://127.0.0.1", %{}, param1: "val1")
      {:ok, %Response{..})

      iex> HTTPClient.request(:get, "http://unknownhost", %{}, param1: "val1")
      {:error, ...}

  """
  def request(method, url, headers, body \\ "")

  def request(method, url, headers, body) when is_binary(body) do
    url     = String.to_char_list(url)
    headers = headers |> Dict.put_new("content-type", "application/json")
    ct_type = headers["content-type"] |> String.to_char_list

    header = Enum.map headers, fn {k, v} ->
      {String.to_char_list(k), String.to_char_list(v)}
    end

    case method do
      :get -> :httpc.request(:get, {url, header}, [], body_format: :binary)
      _    -> :httpc.request(method, {url, header, ct_type, body}, [], body_format: :binary)
    end |> format_resp
  end

  def request(method, url, headers, body) do
    Logger.debug body
    { :ok, json_body } = JSON.encode(body)
    request(method, url, headers, json_body)
  end


  defp format_resp({:ok, {{_http, status, _status_phrase}, headers, body}}) do
    {:ok, %{status: status, headers: headers, body: body}}
  end
  defp format_resp({:error, reason}), do: {:error, reason}
end

