class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :priority, presence: true, numericality: { only_integer: true}
  validates :due_date, presence: true
end
