class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.integer :rating
      t.string :address
      t.string :cuisine
      t.string :phone
      t.integer :price
      t.string :image_1
      t.string :image_2
      t.string :image_3

      t.timestamps
    end
  end
end
