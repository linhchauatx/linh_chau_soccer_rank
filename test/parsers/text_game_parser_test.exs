defmodule SoccerRank.Parsers.TextGameParserTest do
  alias SoccerRank.Parsers.TextGameParser

  use ExUnit.Case

  describe "calculate points from scores" do
    test "return correct points for score_1 > score_2" do
      assert TextGameParser.calculate_points(1, 0) == [3, 0]
    end

    test "return correct points for score_1 < score_2" do
      assert TextGameParser.calculate_points(0, 1) == [0, 3]
    end

    test "return correct points for score_1 == score_2" do
      assert TextGameParser.calculate_points(2, 2) == [1, 1]
    end
  end

  describe "parse team info in to team name and score" do
    test "parse team info with team name that has no space" do
      assert TextGameParser.parse_team_name_and_score("Lions 3") == {"Lions", 3}
    end

    test "parse team info with team name that has space" do
      assert TextGameParser.parse_team_name_and_score("FC Awesome 0") == {"FC Awesome", 0}
    end
  end

  describe "replace team scores with team points" do
    test "replace with one team win" do
      assert TextGameParser.replace_scores_with_points({"Tarantulas", 2}, {"FC Awesome", 1}) ==
        [{"Tarantulas", 3}, {"FC Awesome", 0}]
    end

    test "replace with two teams tie" do
      assert TextGameParser.replace_scores_with_points({"Tarantulas", 2}, {"FC Awesome", 2}) ==
        [{"Tarantulas", 1}, {"FC Awesome", 1}]
    end
  end

  describe "parse one line into two team's name and score tuples" do
    test "parse one line with one team win" do
      assert TextGameParser.parse_one_line("Tarantulas 1, FC Awesome 0") == [{"Tarantulas", 3}, {"FC Awesome", 0}]
    end

    test "parse one line with two teams tie" do
      assert TextGameParser.parse_one_line("Tarantulas 2, FC Awesome 2") == [{"Tarantulas", 1}, {"FC Awesome", 1}]
    end
  end

  describe "put name and point into result" do
    test "put new team and point into result" do
      result = %{}
      assert TextGameParser.put_team_point_into_result(result, {"Tarantulas", 1}) == %{"Tarantulas" => 1}
    end

    test "put new point for existing team into result" do
      result = %{"Tarantulas" => 2}
      assert TextGameParser.put_team_point_into_result(result, {"Tarantulas", 1}) == %{"Tarantulas" => 3}
    end
  end

  describe "parse multi-lines text input" do
    test "parse text input" do
      assert TextGameParser.parse("Lions 3, Snakes 3\nTarantulas 1, FC Awesome 0") == %{ "Lions" => 1, "Snakes" => 1, "Tarantulas" => 3, "FC Awesome" => 0}
    end
  end
end
