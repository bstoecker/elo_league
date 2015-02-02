class EloValueInitializer
  def initialize(league)
    @league = league
  end

  def elo_value_map
    user_elos = initial_user_elos
    { user_elos: user_elos, team_elos: {} }
  end

  private

  def initial_user_elos
    @league.users.reduce({}) do |a, user|
      a.merge(
        user.id => [EloUserValue.new(date: start_date, value: 1500)]
      )
    end
  end

  def start_date
    @league.created_at.to_date
  end
end
