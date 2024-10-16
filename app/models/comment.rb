class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :news
  validates :content, presence: true 
end
