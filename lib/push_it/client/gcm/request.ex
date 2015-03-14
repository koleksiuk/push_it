defmodule PushIt.Client.GCM.Request do
  use HTTPotion.Base

  require Logger

  def call(push) do
    post(push.url, body: push.struct)
  end

  def process_request_body(push_struct) do
    { :ok, json } = JSON.encode(push_struct)

    json
  end

  def process_request_headers(headers) do
    Dict.put(headers, :"content-type", "application/json")
  end
end


