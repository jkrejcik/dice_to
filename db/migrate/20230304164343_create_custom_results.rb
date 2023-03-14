class CreateCustomResults < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_results do |t|
      t.string :question
      t.string :answer
      t.references :user

      t.timestamps
    end
  end
end
