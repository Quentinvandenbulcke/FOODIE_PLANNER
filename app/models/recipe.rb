class Recipe < ApplicationRecord
  has_many :meal_days
  has_many :ingredients
  has_one_attached :photo
  validates :name, :description, presence: true
  validates :prep_time, :rating, :servings, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
