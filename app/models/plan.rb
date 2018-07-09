class Plan < ApplicationRecord
  validates :goal, presence: true, length:{in:1..50}
  belongs_to :user

end
