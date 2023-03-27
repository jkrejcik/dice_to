class AddAcceptedColumnToRestaurantResult < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurant_results, :accepted, :boolean
  end
end
