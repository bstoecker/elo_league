class EloValueUser < EloValue
  belongs_to :user, dependent: :destroy


end
