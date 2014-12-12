class League < ActiveRecord::Base
  has_many :teams
  has_and_belongs_to_many :users
  has_many :results
  has_many :invitations
end
