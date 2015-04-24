class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.integer :available_spaces
      t.text :description
      t.string :country
      t.string :city
      t.string :address
      t.string :post_code
      t.float :price_hour
      t.float :price_week
      t.float :price_month
      t.float :latitude
      t.float :longitude
      t.date :date_from
      t.date :date_until
      t.time :time_from
      t.time :time_until
      t.boolean :available_weekend

      t.timestamps null: false
    end
  end
end
