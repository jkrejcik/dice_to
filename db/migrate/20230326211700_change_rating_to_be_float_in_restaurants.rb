class ChangeRatingToBeFloatInRestaurants < ActiveRecord::Migration[7.0]
  def change
    change_column :restaurants, :rating, :float
  end
end
