class League < ActiveRecord::Base
  has_many :teams
  has_many :users
  has_many :results
end
