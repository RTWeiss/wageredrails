class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :bet

	validates :content, length: { in: 4..300 }
	validates_presence_of :created_at
	before_validation :set_created_at

	def set_created_at
		self.created_at = Time.now
	end
end