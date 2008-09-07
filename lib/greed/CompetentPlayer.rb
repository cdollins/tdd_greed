class CompetentPlayer
  def start_game
  end
  def start_turn(your_score, other_scores)
    @my_score = your_score
    @thier_scores = other_scores
  end
  def roll_again?(accumulated_points, remaining_dice)
    return true if accumulated_points < 300 && @my_score < 300
    return true if @thier_scores.any? { |score| 3000 >= score }
  end
end
