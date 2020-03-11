defmodule PolarisWeb.PageController do
  use PolarisWeb, :controller

  alias Polaris.Page
  alias Polaris.Site

  def index(conn, _params) do
    %Page{title: title, content: content} = Site.index()

    conn
    |> assign(:page_title, title)
    |> assign(:pars, content["pars"])
    |> render("index.html")
  end

  def section(conn, %{"section" => section, "file" => file}) do
    %Page{title: title, content: content} = Page.make_key(section, String.replace(file, "html", "conf")) |> Site.get()

    conn
    |> assign(:page_title, title)
    |> assign(:pars, content["pars"])
    |> render("sections.html")
  end
end
