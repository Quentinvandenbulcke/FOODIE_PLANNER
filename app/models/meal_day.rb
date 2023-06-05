class MealDay < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :date, presence: true
  validates :quantity, presence: true, numericality: {{ only_integer: true, greater_than: 0 }}
end
