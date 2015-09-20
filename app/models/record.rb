class Record < ActiveRecord::Base
  belongs_to :team
  has_many :games, :class_name => 'Game', foreign_key: 'season_id'
end