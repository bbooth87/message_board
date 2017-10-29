class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user
end
# Comments belong to both users and messages.
