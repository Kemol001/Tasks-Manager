class Task < ApplicationRecord
  belongs_to :category
  validates :title, :due_date, presence: true
end
