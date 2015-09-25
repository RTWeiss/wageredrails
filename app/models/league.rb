class League < ActiveRecord::Base

  has_many :teams, class_name: 'Team', foreign_key: 'team_id'

  has_many :games, class_name: 'Game', foreign_key: 'league_id'

  has_many :team_records, through: :teams

end