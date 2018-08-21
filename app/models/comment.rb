class Comment < ApplicationRecord
  belongs_to :plan
  validates :body, presence: true
  
end
