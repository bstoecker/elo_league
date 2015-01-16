class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include ActiveModel::Serializers::JSON
  default_scope -> { order('last_name ASC') }
  has_and_belongs_to_many :teams, dependent: :destroy
  has_many :elo_user_values, dependent: :destroy
  has_and_belongs_to_many :leagues
  has_many :invitations, dependent: :destroy

  validates :email, uniqueness: true
  validates :nick_name, uniqueness: true, presence: true

  def create_or_update_elo_by_diff(elo_diff, date, league_id)
    item = EloUserValue.find_or_initialize_by(
      user: self, date: date, league_id: league_id
    )
    item.update_attributes(value: current_elo(league_id) + elo_diff)
  end

  def current_elo(league_id)
    elo = elo_user_values.where(league_id: league_id).last
    elo ? elo.value : 1500
  end

  def matches(league_id, &block)
    teams.where(league_id: league_id).flat_map do |team|
      block_given? ? block.call(team, team.results) : team.results
    end
  end

  def won_matches(league_id)
    matches(league_id) do |team, results|
      results.select { |r| r.winner?(team.id) }
    end
  end

  def draw_matches(league_id)
    matches(league_id) do |_team, results|
      results.select(&:draw?)
    end
  end

  def lost_matches(league_id)
    matches(league_id) do |team, results|
      results.select { |r| r.looser?(team.id) }
    end
  end

  def self.update_users_by_team(team, elo_difference, date)
    team.users.each do |user|
      user.create_or_update_elo_by_diff(elo_difference, date, team.league_id)
    end
  end
end
