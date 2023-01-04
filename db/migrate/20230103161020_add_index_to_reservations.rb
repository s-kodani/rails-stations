class AddIndexToReservations < ActiveRecord::Migration[6.1]
  def change
    add_index :reservations, [:schedule_id, :sheet_id], unique: true
  end
end
