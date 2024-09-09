defmodule SoccerRank.Parsers.TextGameParser do
  def parse(input) do
    String.split(input, "\n", trim: true)
    |>  Enum.reduce(%{}, fn line, result ->
          [team_1, team_2] = parse_one_line(line)
          result
          |> put_team_point_into_result(team_1)
          |> put_team_point_into_result(team_2)
        end)
  end

  def parse_one_line(line) do
    [team_info_1, team_info_2] = String.split(line, ", ")
    replace_scores_with_points(parse_team_name_and_score(team_info_1), parse_team_name_and_score(team_info_2))
  end

  def parse_team_name_and_score(team_info) do
    [team_name, team_score_str] = Regex.split(~r{.+\s}, team_info, [include_captures: true, trim: true])
    {String.trim(team_name), String.to_integer(team_score_str)}
  end

  def put_team_point_into_result(result, {name, point}) do
    Map.put(result, name, Map.get(result, name, 0) + point)
  end

  def replace_scores_with_points({name_1, score_1}, {name_2, score_2}) do
    [point_1 ,point_2] = calculate_points(score_1, score_2)
    [{name_1, point_1}, {name_2, point_2}]
  end

  def calculate_points(score_1, score_2) when (score_1 > score_2), do: [3, 0]
  def calculate_points(score_1, score_2) when (score_1 < score_2), do: [0, 3]
  def calculate_points(score_1, score_2) when (score_1 == score_2), do: [1, 1]
end
