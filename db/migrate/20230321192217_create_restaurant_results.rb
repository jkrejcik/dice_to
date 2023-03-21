class CreateRestaurantResults < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_results do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :time_taken
      t.integer :rating

      t.timestamps
    end
  end
end
