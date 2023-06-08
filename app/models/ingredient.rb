class Ingredient < ApplicationRecord
  belongs_to :recipe
  has_many :grocery_lists

  validates :name, presence: true
  validates :unit, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
