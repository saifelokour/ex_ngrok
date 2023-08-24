defmodule Ngrok do
  @moduledoc """
  By including this application, an Ngrok
  process will be started when your application starts
  and stopped when your application stops
  """
  use Application

  def start(_type, _args) do

    children = [
      %{
        id: Ngrok.Executable,
        start: {Ngrok.Executable, :start_link, []}
      },
      %{
        id: Ngrok.Settings,
        start: {Ngrok.Settings, :start_link, []}
      }
    ]

    opts = [strategy: :rest_for_one, name: Ngrok.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Retrieves the public URL of the Ngrok tunnel

  ## Example

      Ngrok.public_url # => http://(.*).ngrok.io/
  """
  @spec public_url :: String.t
  def public_url do
    Ngrok.Settings.get("public_url")
  end
end
