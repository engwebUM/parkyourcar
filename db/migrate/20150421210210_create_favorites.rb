class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :space, index: true, null: false

      t.timestamps null: false
    end
  end
end
