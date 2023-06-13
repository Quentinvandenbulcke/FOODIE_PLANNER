class Grocery < ApplicationRecord
  has_many :meal_days
  belongs_to :user
  has_many :grocery_lists, dependent: :destroy
  has_many :grocery_deltas, dependent: :destroy
end
