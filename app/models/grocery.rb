class Grocery < ApplicationRecord
  belongs_to :user
  has_many :grocery_lists, dependent: :destroy
  has_many :meal_days, through: :grocery_lists
  has_many :grocery_deltas, dependent: :destroy
end
