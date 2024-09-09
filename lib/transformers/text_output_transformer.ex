defmodule SoccerRank.Transformers.TextOutputTransformer do
  def team_sorter({name_1, point_1}, {name_2, point_2}) when (point_1 == point_2), do: (name_1 < name_2)
  def team_sorter({_, point_1}, {_, point_2}), do: (point_1 > point_2)

  def build_ranks_and_teams(teams_and_points) do
    Enum.sort(teams_and_points, &team_sorter/2)
    |> Enum.reduce({[], 1, -1, 0}, fn(team_info, {ranks_and_teams, rank, pre_point, team_count}) ->
        {_, point} = team_info

        {team_count, rank} = if pre_point != point do
            {1, rank + team_count}
          else
            {team_count + 1, rank}
          end

        {ranks_and_teams ++ [{rank, team_info}], rank, point, team_count}
      end)
    |> elem(0)
  end
end
