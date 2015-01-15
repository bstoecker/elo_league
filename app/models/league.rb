class League < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_and_belongs_to_many :users
  has_many :results, dependent: :destroy
  has_many :invitations, dependent: :destroy
end
