class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :space, index: true
      t.datetime :date_from
      t.datetime :date_until
      t.string :state

      t.timestamps null: false
    end
  end
end
