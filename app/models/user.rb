class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  
  has_many :initiated_bets,
    :class_name => "Bet",
    :foreign_key => "initiating_user_id"

  has_many :received_bets,
    :class_name => "Bet",
    :foreign_key => "receiving_user_id"
    
  has_one :image

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  :length => { maximum: 255 },
  :format => { :with => VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  validates :username, presence: true,
  :length => { :within => 5..50 },
  uniqueness: { case_sensitive: false }

end
