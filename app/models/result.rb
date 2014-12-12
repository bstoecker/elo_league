class Result < ActiveRecord::Base
  belongs_to :league
  default_scope -> { order('date ASC') }
  after_save :update_elo

  def self.create_from(params)
    league = params.fetch(:league)
    team1 = Team.find_by_users_or_create(league, params.fetch(:user_ids1))
    team2 = Team.find_by_users_or_create(league, params.fetch(:user_ids2))
    result_params = params.merge(team_id1: team1.id, team_id2: team2.id)
                    .reject { |k, _| k == :user_ids1 || k == :user_ids2 }
    Result.add_result_by_params(result_params)
  end

  def self.add_result_by_params(params)
    transaction do
      result = Result.new(params)
      result.save!
      result
    end
  end

  def is_winner?(team_id)
    case
    when team_id1 == team_id then score1 > score2
    when team_id2 == team_id then score1 < score2
    else fail 'team was not included in match'
    end
  end

  def is_draw?
    score1 == score2
  end

  def is_looser?(team_id)
    !(is_winner?(team_id) || is_draw?)
  end

  def update_elo
    team1 = Team.find_by(id: team_id1)
    team2 = Team.find_by(id: team_id2)
    EloTeamValue.update_for(team1, team2, score1, score2, date)
  end
end
