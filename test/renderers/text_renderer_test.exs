defmodule SoccerRank.Renderers.TextRendererTest do
  alias SoccerRank.Renderers.TextRenderer

  use ExUnit.Case

  describe "point_text/1" do
    test "return pt for 1" do
      assert TextRenderer.point_text(1) == "pt"
    end

    test "return pts for other numbers" do
      assert TextRenderer.point_text(3) == "pts"
    end
  end

  describe "format_one_line/1" do
    test "format one output line" do
      assert TextRenderer.format_one_line({1, {"Tarantulas", 3}}) == "1. Tarantulas, 3 pts"
    end
  end

  describe "render/1" do
    test "render ranks_and_teams" do
      ranks_and_teams = [
                          {1, {"Tarantulas", 3}},
                          {2, {"Lions", 1}},
                          {2, {"Snakes", 1}},
                          {4, {"FC Awesome", 0}}
                        ]

      expected_text = """
        1. Tarantulas, 3 pts
        2. Lions, 1 pt
        2. Snakes, 1 pt
        4. FC Awesome, 0 pts
        """

      assert TextRenderer.render(ranks_and_teams) == expected_text
    end
  end
end
