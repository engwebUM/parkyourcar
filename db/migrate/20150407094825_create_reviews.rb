class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true
      t.belongs_to :space, index: true
      t.integer :evaluation
      t.string :text_comment
      t.timestamps null: false
    end
  end
end
