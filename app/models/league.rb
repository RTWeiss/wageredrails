class League < ActiveRecord::Base

  has_many :teams, class_name: 'Team', foreign_key: 'team_id'

  has_many :games

  has_many :team_records, through: :teams


end