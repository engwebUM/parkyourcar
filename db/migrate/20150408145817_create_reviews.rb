class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :evaluation
      t.text :comment

      t.timestamps null: false
    end
  end
end
