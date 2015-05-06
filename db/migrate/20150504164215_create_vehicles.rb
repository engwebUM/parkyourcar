class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, index: true
      t.string :plate
      t.string :make
      t.string :model

      t.timestamps null: false
    end
    change_table :bookings do |b|
      b.references :vehicle, index: true
    end
  end
end
