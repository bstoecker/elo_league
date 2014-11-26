class EloTeamValue < ActiveRecord::Base
  default_scope -> { order('date ASC') }
  belongs_to :team, dependent: :destroy

  def self.update_for(args)
    current_elo_team1 = args[:team1].elo_team_values.last
    current_elo_team2 = args[:team1].elo_team_values.last
    elo = Elo.new(
      score1: args[:score1],
      score2: args[:score2],
      current_elo1: current_elo_team1.value,
      current_elo2: current_elo_team2.value
    )

    update_teams(args[:team1], args[:team2], elo, args[:date])
  end

  private

  def self.update_teams(team1, team2, elo, date)
    elo_team1 = elo.new_elo1
    elo_team2 = elo.new_elo2

    create_or_update_by(
      { team: team1, date: date }, value: elo_team1
    )
    create_or_update_by(
      { team: team2, date: date }, value: elo_team2
    )
  end

  def self.create_or_update_by(args, additional_args)
    item = EloTeamValue.find_or_initialize_by(args)
    item.update_attributes(args.merge(additional_args))
  end
end
