defmodule Polaris.Site do
  @moduledoc false

  alias Polaris.Page

  pages_paths = "hocon/**/*.conf" |> Path.wildcard() |> Enum.sort()

  pages = for page_path <- pages_paths do
    @external_resource Path.relative_to_cwd(page_path)
    Page.parse!(page_path)
  end

  @pages Enum.reduce(pages, %{}, fn page, map -> Map.put(map, Page.make_key(page), page) end)

  def all_pages() do
    @pages
  end

  def index() do
    get(Page.make_key(nil, "index.conf"))
  end

  def get(key) do
    all_pages()[key]
  end

  def get_urls() do
    all_pages() |> Map.keys() |> Enum.map(fn file -> String.replace(file, "conf", "html") end)
  end

end
