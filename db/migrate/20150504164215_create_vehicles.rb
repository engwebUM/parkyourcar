class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, index: true
      t.string :plate, null: false
      t.string :make
      t.string :model

      t.timestamps null: false
    end
  end
end
