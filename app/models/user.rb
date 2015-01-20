require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt 

  has_many :comments
  has_many :players
  has_one :image

  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    :length => { maximum: 255 },
                    :format => { :with => VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :username, presence: true,
                       :length => { :within => 5..50 },
                       uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  def valid_password?(unhashed_password)
    self.password == unhashed_password
  end

  def self.find_by_email(email)
    self.first(:email => email)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end