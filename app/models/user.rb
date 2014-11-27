class User < ActiveRecord::Base
  include ActiveModel::Serializers::JSON
  default_scope -> { order('nick_name ASC') }
  has_and_belongs_to_many :teams
  has_many :elo_user_values
  belongs_to :league
  after_create :create_initial_elo

  def create_or_update_elo_by_diff(elo_diff, date)
    item = EloUserValue.find_or_initialize_by(user: self, date: date)
    item.update_attributes(value: current_elo.value + elo_diff)
  end

  def current_elo
    elo_user_values.last
  end

  def self.update_users_by_team(team, elo_difference, date)
    team.users.each do |user|
      user.create_or_update_elo_by_diff(elo_difference, date)
    end
  end

  private

  def create_initial_elo
    elo_user_values.create(date: Date.today, value: 1500, league_id: league_id)
  end
end
