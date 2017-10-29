class User < ApplicationRecord
  has_many :messages
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter       

end
# File attributes messages and comments to users, allows users to upload avatar, and adds devise functionality to user. 
