class EloUserValue < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  default_scope -> { order('date ASC') }
end
