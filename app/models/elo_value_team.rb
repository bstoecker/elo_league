class EloTeamValue < EloValue
  belongs_to :team, dependent: :destroy


end
