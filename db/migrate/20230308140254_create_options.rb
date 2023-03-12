class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.references :custom_result, null: false, foreign_key: true
      t.string :input

      t.timestamps
    end
  end
end
