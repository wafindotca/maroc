class AddCheckOutTimeToVistor < ActiveRecord::Migration[5.1]
  def change
    add_column :vistors, :checkout_time, :datetime
  end
end
