class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :space, index: true, null: false
      t.belongs_to :vehicle, index: true, null: false
      t.datetime :date_from, null: false
      t.datetime :date_until, null: false
      t.string :state

      t.timestamps null: false
    end
  end
end
