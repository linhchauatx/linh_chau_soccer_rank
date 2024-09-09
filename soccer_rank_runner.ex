defmodule SoccerRankRunner do
  alias SoccerRank.Parsers.TextGameParser
  alias SoccerRank.Transformers.TextOutputTransformer
  alias SoccerRank.Renderers.TextRenderer

  def read_data do
    options = OptionParser.parse(System.argv(), strict: [filename: :string])
    case options do
      { [{_, filename}], _, _} -> {:ok, input} = File.read(filename); input
      _ -> IO.read(:stdio, :eof)
    end
  end

  def execute do
    read_data()
    |> TextGameParser.parse()
    |> TextOutputTransformer.build_ranks_and_teams()
    |> TextRenderer.render()
    |> IO.puts()
  end
end


SoccerRankRunner.execute
