defmodule PolarisWeb.PageView do
  use PolarisWeb, :view

  def markdown(string) do
    with {:ok, html_doc, []} <- Earmark.as_html(strip_margin(string)) do
      html_doc
    end
  end

  def strip_margin(string) do
    String.split(string, "\n")
    |> Enum.map(fn line -> strip_margin_line(line) end)
    |> Enum.join("\n")
  end

  def strip_margin_line(<<"|", rest::bits>>) do
    rest
  end
  def strip_margin_line(<<" ", rest::bits>>) do
    strip_margin_line(rest)
  end
  def strip_margin_line(string) do
    string
  end

end
