defmodule Polaris.Page do

  @moduledoc false

  alias Polaris.Page

  @enforce_keys [:filename, :title, :content]
  defstruct [:filename, :section, :title, :content]

  def parse!(filename) do
    # Get the last two path segments from the filename
    [section, file] = filename |> Path.split() |> Enum.take(-2)

    section = case section do
      "hocon" -> nil
      other   -> other
    end

    case Hocon.decode(File.read!(filename)) do
      {:ok, data}   -> %Page{filename: file, section: section, title: data["title"], content: data}
      {:error, msg} -> %Page{filename: file, section: section, title: "Error", content: %{msg: msg}}
    end
  end

  def make_key(nil, filename) do
    filename
  end
  def make_key(section, filename) do
    section <> "/" <> filename
  end
  def make_key(%Page{filename: filename, section: nil}) do
    filename
  end
  def make_key(%Page{filename: filename, section: section}) do
    section <> "/" <> filename
  end
end
