class EloValueTeam < EloValue
  belongs_to :team, dependent: :destroy


end