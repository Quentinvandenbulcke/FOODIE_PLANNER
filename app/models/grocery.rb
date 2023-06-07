class Grocery < ApplicationRecord
  belongs_to :meal_day
  belongs_to :user
end
