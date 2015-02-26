class Image < ActiveRecord::Base
  belongs_to :user

  mount_uploader :source, ImageUploader
  validates_presence_of :source,
  :message => "You did not choose a file to upload."

  before_validation :set_created_at

  def set_created_at
    self.created_at = Time.now
  end

  def icon40_url
    self.source.icon40.url 
  end

  def icon60_url
    self.source.icon60.url
  end

  def profile_url
    self.source.profile.url
  end
end