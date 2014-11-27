class Elo
  def initialize(args)
    @score1 = args.fetch(:score1)
    @score2 = args.fetch(:score2)
    fail 'sum of scores need to be greater than 0' if @score1 + @score2 <= 0
    @current_elo1 = args.fetch(:current_elo1)
    @current_elo2 = args.fetch(:current_elo2)
  end

  def new_elo1
    @current_elo1 + elo_difference1
  end

  def elo_difference1
    @elo_difference1 ||= elo_difference(@current_elo1,
                                        @current_elo2,
                                        @score1,
                                        @score2)
  end

  def new_elo2
    @current_elo2 + elo_difference2
  end

  def elo_difference2
    @elo_difference2 ||= elo_difference(@current_elo2,
                                        @current_elo1,
                                        @score2,
                                        @score1)
  end

  private

  def elo_difference(current_elo_i, current_elo_j, score_i, score_j)
    const = elo_constant(current_elo_i, score_i, score_j)
    win_point = elo_win_point(score_i, score_j)
    expectation = elo_expectation(current_elo_i, current_elo_j)
    const * (win_point - expectation)
  end

  # Not the original elo constant. It is weigted with the exact result
  def elo_constant(current_elo_i, score_i, score_j)
    weight = (score_i - score_j).to_f.abs / [score_i, score_j].max
    return 10 * weight if current_elo_i  > 2400
    20 * weight
  end

  def elo_expectation(current_elo_i, current_elo_j)
    power_const = (current_elo_j - current_elo_i) / 400
    divisor = 1 + 10**power_const
    1.0 / divisor
  end

  def elo_win_point(score_i, score_j)
    case
    when score_i < score_j then 0.0
    when score_i > score_j then 1.0
    when score_i == score_j then 0.5
    end
  end
end
