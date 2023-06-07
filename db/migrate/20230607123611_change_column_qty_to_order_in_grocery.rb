class ChangeColumnQtyToOrderInGrocery < ActiveRecord::Migration[7.0]
  def change
    change_column :groceries, :qty_to_order, :decimal
  end
end
