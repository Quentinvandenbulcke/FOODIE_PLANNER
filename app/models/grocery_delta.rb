class GroceryDelta < ApplicationRecord
  belongs_to :ingredient
  belongs_to :grocery
end
