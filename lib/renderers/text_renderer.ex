defmodule SoccerRank.Renderers.TextRenderer do
  def render(ranks_and_teams) do
    Enum.reduce(ranks_and_teams, "", fn rank_and_team, line ->
      line <> format_one_line(rank_and_team) <> "\n"
    end)
  end

  def format_one_line({rank, {name, point}}) do
    "#{rank}. #{name}, #{point} #{point_text(point)}"
  end

  def point_text(1), do: "pt"
  def point_text(_), do: "pts"
end
