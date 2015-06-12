require 'digest/md5'

class User < ActiveRecord::Base
  attr_accessible :avatar_url, :bio, :email, :password, :password_confiramtion, :username
  has_secure_password
  
  before_validation :prep_email
  before_save :create_avatar_url
  
  validates :email, presence: true, uniqueness: true, format:{ with: /^[\w\.+-]+@([\w]+\.)+[a-zA-Z] }
  
  validates :username, presence: true, unqinesses: true
  validates :name, presence: true
  
  private

  def prep_email
    self.email = self.email.strip.downcase if self.email
  end
  
  def create_avatar_url
    self.avatar_url="http://www.ravatar/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
  end
end

