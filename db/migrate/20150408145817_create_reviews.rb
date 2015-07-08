class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :space, index: true, null: false
      t.integer :evaluation, null: false
      t.text :comment, null: false

      t.timestamps null: false
    end
  end
end
