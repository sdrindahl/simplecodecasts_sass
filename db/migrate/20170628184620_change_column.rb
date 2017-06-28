class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :plans, :price, :decimal
  end
end
