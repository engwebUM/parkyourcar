class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.belongs_to :user, index: true
      t.string :title, null: false
      t.integer :available_spaces, null: false
      t.text :description, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :post_code, null: false
      t.float :price_hour, null: false
      t.float :price_week
      t.float :price_month
      t.float :latitude
      t.float :longitude
      t.datetime :date_from, null: false
      t.datetime :date_until, null: false
      t.boolean :available_weekend
      t.integer :reviews_count, null: false, default: 0, index: true

      t.timestamps null: false
    end
  end
end
