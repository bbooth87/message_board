class Message < ApplicationRecord
  belongs_to :user
  has_many :comments
  mount_uploader :video, VideoUploader
  acts_as_votable
  scope :recent, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
  scope :upvoted, -> { order(:cached_votes_up => :desc) }
  scope :downvoted, -> { order(:cached_votes_down => :desc) }



end
#Allows filterable options allow's videos to be uploaded and allow comments on messages. This file also attributes messages to users.
