class GroceryList < ApplicationRecord
  belongs_to :ingredient
  belongs_to :grocery
end
