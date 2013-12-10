defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    conn.fetch([:params])
  end

  def nurble(text) do
    nouns = File.stream!("nouns.txt", [], :line)
            |> Enum.map &(String.strip(&1) |> String.downcase)
  
    text
    |> String.downcase
    |> String.replace(%r/[^a-z ]/, "")
    |> String.split
    |> Enum.reduce(text, &handle_noun(&2, &1, nouns))
    |> String.replace(%r/\n/, '<br/>')
  end

  def handle_noun(text, word, nouns) do
    unless Enum.member?(nouns, word) do
      String.replace(text, %r/(\b)#{word}(\b)/, "<span class=\"nurble\">nurble</span>")
    else
      text
    end
  end

  get "/" do
    conn = conn.assign(:title, "Welcome to Dynamo!")
    render conn, "index"
  end

  post "/nurble" do
    conn = conn.assign(:nurbles, nurble(conn.params[:text]))
    render conn, "index"
  end

end
