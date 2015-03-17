defmodule PushIt.Client.GCM.Request do
  use HTTPotion.Base

  require Logger

  def perform(push) do
    post(push.url, body: push.struct, headers: push_headers(push))
  end

  def process_request_body(push_struct) do
    { :ok, json } = JSON.encode(push_struct)

    json
  end

  def process_request_headers(headers) do
    Dict.put(headers, :"content-type", "application/json")
  end

  defp push_headers(push) do
    [ Authorization: "key=#{push.api_key}" ]
  end
end
