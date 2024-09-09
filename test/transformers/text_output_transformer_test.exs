defmodule SoccerRank.Transformers.TextOutputTransformerTest do
  alias SoccerRank.Transformers.TextOutputTransformer

  use ExUnit.Case

  describe "team_sorter/2" do
    test "sort team with different point" do
      assert TextOutputTransformer.team_sorter({"XYZ", 7}, {"ABC", 5}) == true
      assert TextOutputTransformer.team_sorter({"ABC", 5}, {"XYZ", 7}) == false
    end

    test "sort team with the same point" do
      assert TextOutputTransformer.team_sorter({"ABC", 5}, {"XYZ", 5}) == true
      assert TextOutputTransformer.team_sorter({"XYZ", 5}, {"ABC", 5}) == false
    end
  end

  describe "build_ranks_and_teams/1" do
    test "create a list with elements are tuples of {ranks, {team_name, team_point}}" do
      teams_and_points = %{ "Lions" => 1, "Snakes" => 1, "Tarantulas" => 3, "FC Awesome" => 0}

      assert TextOutputTransformer.build_ranks_and_teams(teams_and_points) == [
                                                                                {1, {"Tarantulas", 3}},
                                                                                {2, {"Lions", 1}},
                                                                                {2, {"Snakes", 1}},
                                                                                {4, {"FC Awesome", 0}}
                                                                              ]

    end
  end
end
