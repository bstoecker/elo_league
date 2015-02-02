class EloValues
  :league

  def initialize(league)
    @league = league
    @elo_updater = EloUpdater.new
  end

  def for_user(user)
    elo_map[:user_elos][user.id]
  end

  def for_team(team)
    elo_map[:team_elos][team.id]
  end

  private

  def elo_map
    @elo_map ||= generate_elo_map
  end

  def generate_elo_map
    elo_map = EloValueInitializer.new(@league).elo_value_map

    results = @league.results.order(date: :asc, created_at: :asc)
    results.each do |result|
      @elo_updater.update_elo_map(elo_map, result)
    end
    elo_map
  end
end
