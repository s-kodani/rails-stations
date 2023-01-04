class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date "date", null: false
      t.references :schedule, null: false, foreign_key: true, index: true
      t.references :sheet, null: false, foreign_key: true, index: true
      t.string "email", null: false, limit: 255, comment: "予約者メールアドレス"
      t.string "name", null: false, limit: 50, comment: "予約社名"
      
      t.timestamps
    end
  end
end
