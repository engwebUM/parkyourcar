class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :date_from
      t.datetime :date_until

      t.timestamps null: false
    end
  end
end
