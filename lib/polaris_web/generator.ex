defmodule PolarisWeb.Generator do
  @moduledoc false

  use Phoenix.ConnTest
  @endpoint PolarisWeb.Endpoint

  def generate() do
    conn = Phoenix.ConnTest.build_conn()
    base = Application.get_env(:polaris, :generator)[:out]

    with :ok <- clean_files(base),
        :ok <- copy_assets(base) do
      Polaris.Site.get_urls()
      |> Enum.map(fn url -> generate(conn, url) end)
      |> Enum.map(fn {url, content} -> write_file(url, content, base)  end)
    else
      error -> error
    end
  end

  def generate(conn, url) do
    {url, html_response(get(conn, url), 200)}
  end

  defp clean_files(base) do
    with {:ok, _} <- File.rm_rf(base) do
      :ok
    else
      error -> error
    end
  end

  def copy_assets(base) do
    src = ["priv","static"] |> Path.join() |> Path.relative_to_cwd()
    src = src <> "/"
    pars = ["-r", src, base]
    with {_out, 0} <- System.cmd("rsync", pars) do
      :ok
    else
      error -> error
    end
  end

  def write_file(path, content, base) do
    full_path = Path.join(base, path)
    dirname   = Path.dirname(full_path)
    with :ok <- File.mkdir_p(dirname),
         :ok <- File.write(full_path, content) do
      {:ok, path}
    else
      _ -> {:error, path}
    end
  end
end