class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :space, index: true
      t.date :date_from
      t.date :date_until
      t.time :time_from
      t.time :time_until
      t.string :state

      t.timestamps null: false
    end
  end
end
